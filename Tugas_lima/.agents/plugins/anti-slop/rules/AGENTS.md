# Anti-Slop Guidelines & Quality Standards

## 1. Zero Conversational Slop
- **Direct & Concise**: Answer directly without fluff, disclaimers, generic introductions ("Certainly!", "Sure thing!"), or artificial pleasantries.
- **No Sycophancy**: Avoid exaggerated praise, fake enthusiasm, and meta-commentary about the process.
- **Action-Oriented**: Focus on code changes, technical facts, and clear diffs.

## 2. Zero Code Slop
- **No Placeholders**: Never leave incomplete code with `// TODO: implement this`, `// add your logic here`, or dummy placeholders unless explicitly requested. Write complete, functional implementations.
- **No Useless Comments**: Do not write comments that merely restate what the code clearly expresses (e.g. `// increment count`, `// return result`). Comments must explain non-obvious rationale and domain logic only.
- **No Over-Engineering**: Avoid unnecessary wrapper functions, speculative generalizations, or redundant abstraction layers. Write straightforward, idiomatic code that fits the codebase.
- **Clean Patterns**: Adhere strictly to existing conventions, formatting, and dependency injection/state management patterns in the project.

## 3. UI & Design Standards
- **Intentional Design**: Avoid generic, cookie-cutter AI layouts. Maintain consistent typography, proper spacing, clear visual hierarchy, and intuitive user feedback.
- **Responsiveness & Accessibility**: Ensure UI components adapt gracefully to various screen sizes and follow accessibility guidelines.

## 4. Verification & Correctness
- **Compiler / Static Analysis**: Ensure changes pass static analysis and compilation checks without warnings or errors.
- **Honest Accuracy**: Never hallucinate APIs, methods, or package versions. Verify imports and dependencies.
