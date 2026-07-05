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

---

<div class="style-sample style-corporate">
  <div class="style-topline">
    <span>方案 A</span>
    <b>华为式高密度胶片</b>
    <span class="style-desc">适合正式汇报、领导阅读、跨角色快速扫读</span>
  </div>
  <div class="sample-header">
    <h2>电子流信息对比：Agent 把“查表”推进到“可判断”</h2>
    <p>用户输入两条电子流编号，目标不是拿到两张信息表，而是确认状态差异、关键字段差异和下一步处理动作。</p>
  </div>
  <div class="corporate-grid">
    <div class="corporate-table">
      <div class="t-head">对比维度</div>
      <div class="t-head">电子流 A</div>
      <div class="t-head">电子流 B</div>
      <div class="t-head red">Agent 判断</div>
      <div>当前节点</div>
      <div>复核中</div>
      <div>已归档</div>
      <div class="warn">存在流程进度差异</div>
      <div>停留时长</div>
      <div>18 小时</div>
      <div>2 小时</div>
      <div class="warn">A 超出常规阈值</div>
      <div>关键字段</div>
      <div>金额口径：新版</div>
      <div>金额口径：旧版</div>
      <div class="warn">字段版本不一致</div>
      <div>建议动作</div>
      <div>补查回退记录</div>
      <div>确认归档依据</div>
      <div class="ok">先确认 A 的复核阻塞点</div>
    </div>
    <div class="corporate-side">
      <b>页面气质</b>
      <ul>
        <li>信息密度高，像正式胶片</li>
        <li>表格和结论强，方便拍照留存</li>
        <li>动效少，视觉稳定</li>
      </ul>
    </div>
  </div>
</div>

---

<div class="style-sample style-dashboard">
  <div class="dashboard-shell">
    <div class="dashboard-aside">
      <span>方案 B</span>
      <h2>业务中台看板风</h2>
      <p>适合讲“AI 如何进入业务操作台”，现场演示感更强。</p>
    </div>
    <div class="dashboard-main">
      <div class="dash-title">
        <b>电子流对比工作台</b>
        <span>目标：定位节点差异、字段差异、异常原因</span>
      </div>
      <div class="dash-kpis">
        <div><span>差异项</span><b>3</b></div>
        <div><span>待确认</span><b>1</b></div>
        <div><span>建议动作</span><b>4</b></div>
      </div>
      <div class="dash-body">
        <div class="flow-track">
          <b>流转轨迹</b>
          <div class="track-row active"><span>发起</span><i></i><span>审批</span><i></i><span>复核</span><i></i><span>归档</span></div>
          <div class="track-row"><span>发起</span><i></i><span>审批</span><i></i><span>归档</span></div>
        </div>
        <div class="dash-list">
          <b>Agent 观察</b>
          <p>电子流 A 停留在复核节点，B 已归档。</p>
          <p>两条流的金额口径字段版本不一致。</p>
          <p>需要确认 A 是否发生过审批回退。</p>
        </div>
      </div>
    </div>
  </div>
</div>

---

<div class="style-sample style-consulting">
  <div class="consulting-band">
    <span>方案 C</span>
    <h2>咨询报告风</h2>
    <p>适合把 Agent 讲成一套清晰方法论：目标、证据、判断、建议。</p>
  </div>
  <div class="consulting-content">
    <div class="big-claim">
      <b>结论先行</b>
      <p>电子流对比的关键价值，不是展示更多字段，而是把差异归因到可以处理的动作。</p>
    </div>
    <div class="consulting-matrix">
      <div>
        <span>1</span>
        <b>目标识别</b>
        <p>用户真正想知道两条流是否一致，以及是否需要处理。</p>
      </div>
      <div>
        <span>2</span>
        <b>证据组织</b>
        <p>节点、日志、字段、规则被放到同一个判断框架里。</p>
      </div>
      <div>
        <span>3</span>
        <b>差异解释</b>
        <p>A 卡在复核，B 已归档；字段版本存在不一致。</p>
      </div>
      <div>
        <span>4</span>
        <b>建议动作</b>
        <p>先确认审批回退，再判断是否需要补充归档依据。</p>
      </div>
    </div>
  </div>
</div>

---

<div class="style-sample style-product">
  <div class="product-window">
    <div class="product-sidebar">
      <span>方案 D</span>
      <b>产品演示风</b>
      <p>适合现场边讲边点，像是在展示一个可操作的 Agent 工作台。</p>
      <div class="product-nav">
        <i class="active">电子流对比</i>
        <i>上下文查询</i>
        <i>差异解释</i>
        <i>处理建议</i>
      </div>
    </div>
    <div class="product-main">
      <div class="product-query">对比电子流 EL-001 与 EL-002，找出节点、字段和异常差异</div>
      <div class="product-chat">
        <div class="msg user">请帮我看这两条电子流为什么处理结果不一样。</div>
        <div class="msg agent">
          <b>Agent 分析结果</b>
          <p>我会先查询当前节点和流转日志，再对比关键字段版本。当前发现 3 个差异，其中 1 个需要人工确认。</p>
        </div>
      </div>
      <div class="product-result">
        <div><span>节点差异</span><b>A 复核中 / B 已归档</b></div>
        <div><span>字段差异</span><b>金额口径版本不一致</b></div>
        <div><span>建议动作</span><b>确认 A 是否审批回退</b></div>
      </div>
    </div>
  </div>
</div>
