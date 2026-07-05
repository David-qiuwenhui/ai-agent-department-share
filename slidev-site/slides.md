---
theme: seriph
title: Agent 原理科普与 AI 工具使用分享
info: |
  部门内部分享材料。目标是帮助不同角色理解 Agent 的基本运行方式，并建立可上手的 AI 工具使用路径。
class: text-left
transition: slide-left
mdc: true
drawings:
  persist: false
---

<section class="cover-page">
  <div class="cover-kicker">部门内部分享 · 30 分钟</div>
  <h1>Agent 原理科普与 AI 工具使用分享</h1>
  <p class="cover-subtitle">从“会回答问题”到“能推进任务”，看清 Agent 的运行结构和实际用法</p>
  <div class="cover-map">
    <div>
      <b>理解</b>
      <span>Agent 是什么</span>
    </div>
    <div>
      <b>看见</b>
      <span>它怎么跑起来</span>
    </div>
    <div>
      <b>上手</b>
      <span>把 AI 用进日常工作</span>
    </div>
  </div>
</section>

---

<section class="slide-page">
  <div class="slide-header">
    <span class="page-index">01</span>
    <h2>Agent 不是一个新按钮，而是一种任务运行方式</h2>
  </div>

  <div class="two-column compare-intro">
    <div class="panel quiet">
      <div class="panel-label">Chat AI</div>
      <h3>一次问答</h3>
      <p>人提出问题，模型给出回答。输出质量主要取决于问题描述是否清楚。</p>
      <div class="mini-flow">
        <span>问题</span>
        <i></i>
        <span>回答</span>
      </div>
    </div>
    <div class="panel strong">
      <div class="panel-label">Agent</div>
      <h3>持续推进</h3>
      <p>人给出目标，模型围绕目标分解任务、调用工具、观察结果，并决定下一步。</p>
      <div class="mini-flow loop-flow">
        <span>目标</span>
        <i></i>
        <span>行动</span>
        <i></i>
        <span>观察</span>
        <i></i>
        <span>调整</span>
      </div>
    </div>
  </div>

  <div class="bottom-note">这一页只建立直觉：Agent 的重点不是“更聪明地聊天”，而是“围绕目标形成闭环”。</div>
</section>

---

<section class="slide-page">
  <div class="slide-header">
    <span class="page-index">02</span>
    <h2>Workflow 和 Agent 的差异，关键在于“路径是否固定”</h2>
  </div>

  <div class="matrix">
    <div class="matrix-head"></div>
    <div class="matrix-head">Workflow</div>
    <div class="matrix-head">Agent</div>

    <div class="matrix-row-label">任务路径</div>
    <div>事先设计好，按固定步骤执行</div>
    <div>根据目标和观察结果动态调整</div>

    <div class="matrix-row-label">适合场景</div>
    <div>规则稳定、输入清晰、异常少</div>
    <div>信息不完整、需要判断、需要查证</div>

    <div class="matrix-row-label">人的角色</div>
    <div>设计流程，处理例外</div>
    <div>设定目标，校验关键决策</div>

    <div class="matrix-row-label">风险点</div>
    <div>流程外情况容易卡住</div>
    <div>需要边界、权限、评估和追踪</div>
  </div>

  <div class="bottom-note">不是谁替代谁。稳定任务用 Workflow 更可靠，复杂任务可以让 Agent 帮忙探索和推进。</div>
</section>

---

<section class="slide-page demo-slide">
  <div class="slide-header compact">
    <span class="page-index">03</span>
    <h2>同一个电子流对比任务，两种执行方式</h2>
  </div>

  <WorkflowAgentDemo />
</section>

---

<section class="slide-page">
  <div class="slide-header">
    <span class="page-index">04</span>
    <h2>一个最小 Agent，需要四个基本部件</h2>
  </div>

  <div class="agent-parts">
    <div class="part-card">
      <span>Prompt</span>
      <b>目标和规则</b>
      <p>告诉模型要完成什么、以什么标准完成、哪些事情不能做。</p>
    </div>
    <div class="part-card">
      <span>Context</span>
      <b>任务现场</b>
      <p>需求、文档、历史记录、代码、测试用例、用户反馈等背景信息。</p>
    </div>
    <div class="part-card">
      <span>Harness</span>
      <b>工具和边界</b>
      <p>模型能调用哪些工具，能读写什么，谁来审批高风险动作。</p>
    </div>
    <div class="part-card">
      <span>Loop</span>
      <b>执行闭环</b>
      <p>计划、行动、观察、修正，直到达成目标或触发人工确认。</p>
    </div>
  </div>

  <div class="loop-diagram">
    <div>目标</div>
    <i></i>
    <div>计划</div>
    <i></i>
    <div>工具</div>
    <i></i>
    <div>观察</div>
    <i></i>
    <div>调整</div>
  </div>
</section>

---

<section class="slide-page">
  <div class="slide-header">
    <span class="page-index">05</span>
    <h2>工程化 Agent 不是“接上模型”就结束</h2>
  </div>

  <div class="build-map">
    <div class="build-layer">
      <b>任务层</b>
      <span>目标定义 · 输入输出 · 角色分工</span>
    </div>
    <div class="build-layer">
      <b>能力层</b>
      <span>工具调用 · 知识检索 · 工作流编排</span>
    </div>
    <div class="build-layer">
      <b>治理层</b>
      <span>权限控制 · 人工审批 · 日志追踪</span>
    </div>
    <div class="build-layer">
      <b>评估层</b>
      <span>效果样例 · 失败回放 · 质量度量</span>
    </div>
  </div>

  <div class="bottom-note">对业务团队来说，真正要建设的不是一个“万能助手”，而是一套可控、可评估、可迭代的任务系统。</div>
</section>
