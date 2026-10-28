import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Type } from "@sinclair/typebox";
import { execFile } from "node:child_process";
import { promisify } from "node:util";
import { realpath, stat } from "node:fs/promises";
import path from "node:path";

const execFileAsync = promisify(execFile);
const MAX_PDF_BYTES = 50 * 1024 * 1024;
const MAX_TEXT_CHARS = 100_000;
const MAX_OUTPUT_BYTES = 2 * 1024 * 1024;

export default function (pi: ExtensionAPI) {
  pi.registerCommand("pdf-quiz", {
    description: "Create quiz questions from a local PDF",
    handler: async (args) => {
      const filePath = args.trim();
      if (!filePath) {
        pi.sendUserMessage(
          "Use /pdf <path-to-pdf> to create quiz questions from a local PDF.",
        );
        return;
      }
      pi.sendUserMessage(
        `Read the local PDF at ${JSON.stringify(filePath)} with the read_pdf_for_quiz tool, then create source-grounded multiple-choice questions one at a time using the quiz tool.`,
      );
    },
  });

  pi.registerTool({
    name: "read_pdf_for_quiz",
    label: "PDF quiz prep",
    description:
      "Extract lecture content from a local PDF and return it with instructions to create relevant multiple-choice questions using the quiz tool. Use this before quizzing from a PDF. Requires the pdftotext executable (Poppler).",
    parameters: Type.Object({
      filePath: Type.String({
        description:
          "Path to the lecture PDF (absolute or relative to the project).",
      }),
      focus: Type.Optional(
        Type.String({
          description: "Optional topic or learning objectives to prioritize.",
        }),
      ),
      maxQuestions: Type.Optional(
        Type.Integer({
          minimum: 1,
          maximum: 20,
          description: "Suggested question count (default 8, max 20).",
        }),
      ),
    }),
    async execute(_id, params, signal) {
      try {
        const pdfPath = await realpath(path.resolve(params.filePath));
        if (path.extname(pdfPath).toLowerCase() !== ".pdf") {
          return {
            content: [
              {
                type: "text",
                text: "The selected file must have a .pdf extension.",
              },
            ],
            isError: true,
          };
        }
        const fileInfo = await stat(pdfPath);
        if (!fileInfo.isFile() || fileInfo.size > MAX_PDF_BYTES) {
          return {
            content: [
              {
                type: "text",
                text: "PDF must be a regular file no larger than 50 MiB.",
              },
            ],
            isError: true,
          };
        }
        if (signal?.aborted)
          return {
            content: [{ type: "text", text: "PDF extraction cancelled." }],
          };

        // Pass the path as a distinct argument (never through a shell), and cap
        // output so unusually large/scanned documents cannot overwhelm context.
        const { stdout } = await execFileAsync(
          "pdftotext",
          ["-layout", "-enc", "UTF-8", pdfPath, "-"],
          {
            encoding: "utf8",
            maxBuffer: MAX_OUTPUT_BYTES,
            timeout: 30_000,
            signal,
          },
        );
        const text = stdout.replace(/\u0000/g, "").trim();
        if (!text) {
          return {
            content: [
              {
                type: "text",
                text: "No selectable text was found. This may be a scanned PDF; OCR it first (for example with pdftoppm and tesseract).",
              },
            ],
          };
        }
        const excerpt = text.slice(0, MAX_TEXT_CHARS);
        const focus = params.focus?.trim();
        const count = params.maxQuestions ?? 8;
        const truncated = text.length > excerpt.length;
        return {
          content: [
            {
              type: "text",
              text:
                `Extracted lecture PDF: ${path.basename(pdfPath)} (${text.length} characters${truncated ? `; excerpt limited to ${MAX_TEXT_CHARS}` : ""}).\n\n` +
                `Create up to ${count} useful, source-grounded multiple-choice questions from this material. Prioritize core concepts, relationships, mechanisms, and meaningful distinctions; avoid trivia and unsupported facts. Use the existing quiz tool to ask questions one at a time, with plausible but clearly wrong distractors and concise explanations grounded in the lecture. ${focus ? `Prioritize this focus: ${focus}\n\n` : ""}` +
                `--- PDF TEXT ---\n${excerpt}${truncated ? "\n\n[Excerpt truncated; later pages may not be represented.]" : ""}`,
            },
          ],
        };
      } catch (error) {
        const err = error as NodeJS.ErrnoException;
        const message =
          err.code === "ENOENT"
            ? "Could not run pdftotext. Install Poppler (for example: sudo apt install poppler-utils)."
            : err.code === "ERR_CHILD_PROCESS_STDIO_MAXBUFFER"
              ? "PDF text exceeds the extraction limit. Try a smaller or split PDF."
              : err.name === "AbortError"
                ? "PDF extraction cancelled."
                : `Could not read PDF: ${err.message}`;
        return { content: [{ type: "text", text: message }], isError: true };
      }
    },
  });
}
