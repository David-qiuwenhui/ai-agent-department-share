# Agent AI Share Slidev Site

This folder contains the web-based version of the department sharing deck.

## Run Locally

```bash
npm install
npm run dev
```

Then open:

```text
http://localhost:3030
```

## Build

```bash
npm run build
```

## Source Structure

- `slides.md`: slide content and page order.
- `style.css`: shared presentation style.
- `components/WorkflowAgentDemo.vue`: interactive Workflow vs Agent demo.
- `public/`: local images, videos, and static assets.

## Collaboration Rule

Each slide or demo component should remain easy to edit. Prefer Markdown, HTML blocks, CSS, and small Vue components over generated screenshots.
