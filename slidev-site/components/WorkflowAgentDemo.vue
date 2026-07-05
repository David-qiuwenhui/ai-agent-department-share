<template>
  <div class="demo-wrap">
    <div class="scenario-bar">
      <div>
        <span class="bar-label">演示任务</span>
        <b>支付成功回调新增字段，判断影响范围并给出处理建议</b>
      </div>
      <div class="demo-controls">
        <button type="button" @click="prevStep">上一步</button>
        <button type="button" class="primary" @click="nextStep">下一步</button>
        <button type="button" @click="togglePlay">{{ playing ? "暂停" : "播放" }}</button>
        <button type="button" @click="reset">重置</button>
      </div>
    </div>

    <div class="demo-grid">
      <section class="lane workflow-lane">
        <header>
          <span>Workflow</span>
          <b>固定路径</b>
        </header>
        <ol class="step-list">
          <li
            v-for="(step, index) in workflowSteps"
            :key="step.title"
            :class="{ active: index === workflowIndex, done: index < workflowIndex }"
          >
            <i>{{ index + 1 }}</i>
            <div>
              <b>{{ step.title }}</b>
              <p>{{ step.desc }}</p>
            </div>
          </li>
        </ol>
        <div class="lane-result">
          <span>输出</span>
          <p>{{ workflowSteps[workflowIndex].output }}</p>
        </div>
      </section>

      <section class="lane agent-lane">
        <header>
          <span>Agent</span>
          <b>动态闭环</b>
        </header>
        <div class="agent-loop">
          <div
            v-for="(node, index) in agentLoop"
            :key="node"
            class="loop-node"
            :class="{ active: index === agentPhase }"
          >
            {{ node }}
          </div>
        </div>
        <ol class="trace-list">
          <li
            v-for="(step, index) in agentSteps"
            :key="step.title"
            :class="{ active: index === agentIndex, done: index < agentIndex }"
          >
            <i>{{ step.tag }}</i>
            <div>
              <b>{{ step.title }}</b>
              <p>{{ step.desc }}</p>
            </div>
          </li>
        </ol>
        <div class="lane-result agent-result">
          <span>输出</span>
          <p>{{ agentSteps[agentIndex].output }}</p>
        </div>
      </section>
    </div>
  </div>
</template>

<script setup>
import { computed, onBeforeUnmount, ref } from "vue";

const workflowSteps = [
  {
    title: "读取变更说明",
    desc: "按模板抽取字段、接口、上线时间。",
    output: "识别到新增字段，但不知道谁会受影响。"
  },
  {
    title: "套用影响模板",
    desc: "把字段变更填入固定影响分析表。",
    output: "产出一张标准表，覆盖接口、测试、发布三类影响。"
  },
  {
    title: "生成处理建议",
    desc: "根据模板规则给出补充测试和发布提醒。",
    output: "如果输入完整，结果稳定；如果信息缺失，流程会停在模板边界。"
  }
];

const agentSteps = [
  {
    tag: "计划",
    title: "先判断要查什么",
    desc: "拆成接口影响、下游消费方、测试补充、发布风险四个问题。",
    output: "形成一份待查清单，而不是马上写结论。"
  },
  {
    tag: "工具",
    title: "读取上下文",
    desc: "查看接口清单、历史测试用例、近三个月相关缺陷记录。",
    output: "发现字段被对账任务和通知服务消费。"
  },
  {
    tag: "观察",
    title: "发现信息不足",
    desc: "缺少字段为空时的兼容策略，无法判断灰度风险。",
    output: "暂停直接下结论，提出一个需要确认的问题。"
  },
  {
    tag: "调整",
    title: "补充分析路径",
    desc: "把兼容策略作为前置条件，重排测试建议和上线检查项。",
    output: "给 BA、SE、测试、开发分别生成可执行关注点。"
  },
  {
    tag: "交付",
    title: "输出分角色结论",
    desc: "保留证据来源、未确认项和建议动作，方便人工复核。",
    output: "Agent 的价值不是替人拍板，而是把复杂任务推进到可决策状态。"
  }
];

const agentLoop = ["目标", "计划", "工具", "观察", "调整"];
const current = ref(0);
const playing = ref(false);
let timer = null;

const workflowIndex = computed(() => Math.min(current.value, workflowSteps.length - 1));
const agentIndex = computed(() => Math.min(current.value, agentSteps.length - 1));
const agentPhase = computed(() => agentIndex.value % agentLoop.length);
const maxStep = Math.max(workflowSteps.length, agentSteps.length) - 1;

function nextStep() {
  current.value = current.value >= maxStep ? 0 : current.value + 1;
}

function prevStep() {
  current.value = current.value <= 0 ? maxStep : current.value - 1;
}

function reset() {
  current.value = 0;
  stopPlaying();
}

function togglePlay() {
  if (playing.value) {
    stopPlaying();
    return;
  }
  playing.value = true;
  timer = window.setInterval(nextStep, 1800);
}

function stopPlaying() {
  playing.value = false;
  if (timer) {
    window.clearInterval(timer);
    timer = null;
  }
}

onBeforeUnmount(stopPlaying);
</script>

<style scoped>
.demo-wrap {
  height: 510px;
  display: grid;
  grid-template-rows: auto 1fr;
  gap: 14px;
}

.scenario-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
  padding: 16px 18px;
  background: #fff;
  border: 1px solid #d8dde6;
  box-shadow: 0 10px 24px rgba(17, 24, 39, 0.05);
}

.scenario-bar b {
  display: block;
  color: #111827;
  font-size: 18px;
  line-height: 1.35;
}

.bar-label {
  color: #b7242a;
  font-size: 13px;
  font-weight: 850;
}

.demo-controls {
  display: flex;
  gap: 8px;
  flex: 0 0 auto;
}

.demo-controls button {
  height: 34px;
  padding: 0 12px;
  border: 1px solid #cfd5df;
  background: #fff;
  color: #1f242d;
  font-weight: 750;
  font-size: 13px;
  cursor: pointer;
}

.demo-controls button.primary {
  border-color: #b7242a;
  background: #b7242a;
  color: #fff;
}

.demo-grid {
  display: grid;
  grid-template-columns: 1fr 1.12fr;
  gap: 16px;
  min-height: 0;
}

.lane {
  min-height: 0;
  display: grid;
  grid-template-rows: auto 1fr auto;
  gap: 12px;
  padding: 18px;
  background: #fff;
  border: 1px solid #d8dde6;
  box-shadow: 0 12px 30px rgba(17, 24, 39, 0.06);
}

.lane header {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  padding-bottom: 10px;
  border-bottom: 2px solid #edf0f5;
}

.lane header span {
  color: #b7242a;
  font-size: 15px;
  font-weight: 850;
}

.lane header b {
  color: #1f242d;
  font-size: 23px;
}

.step-list,
.trace-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: grid;
  gap: 9px;
  align-content: start;
}

.step-list li,
.trace-list li {
  display: grid;
  grid-template-columns: 34px 1fr;
  gap: 10px;
  padding: 10px;
  border: 1px solid #e2e7ef;
  background: #f8fafc;
  opacity: 0.55;
  transition: 180ms ease;
}

.trace-list li {
  grid-template-columns: 46px 1fr;
  padding: 8px 10px;
}

.step-list li.active,
.trace-list li.active {
  opacity: 1;
  border-color: rgba(183, 36, 42, 0.45);
  background: #fff7f7;
  transform: translateY(-1px);
}

.step-list li.done,
.trace-list li.done {
  opacity: 0.78;
  background: #fff;
}

.step-list i,
.trace-list i {
  width: 34px;
  height: 34px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: #202732;
  color: #fff;
  font-style: normal;
  font-size: 13px;
  font-weight: 850;
}

.trace-list i {
  width: 46px;
}

.step-list b,
.trace-list b {
  display: block;
  color: #111827;
  font-size: 15px;
  margin-bottom: 3px;
}

.step-list p,
.trace-list p {
  color: #586173;
  font-size: 13px;
  line-height: 1.35;
  margin: 0;
}

.agent-lane {
  border-color: rgba(183, 36, 42, 0.32);
}

.agent-loop {
  display: grid;
  grid-template-columns: repeat(5, minmax(0, 1fr));
  gap: 8px;
}

.loop-node {
  text-align: center;
  padding: 8px 6px;
  border: 1px solid #d8dde6;
  background: #f6f8fb;
  color: #485466;
  font-size: 13px;
  font-weight: 800;
}

.loop-node.active {
  border-color: #b7242a;
  background: #b7242a;
  color: #fff;
}

.lane-result {
  min-height: 54px;
  padding: 11px 13px;
  background: #202732;
  color: #fff;
}

.lane-result span {
  display: block;
  color: #f3c6c8;
  font-size: 12px;
  font-weight: 850;
  margin-bottom: 4px;
}

.lane-result p {
  margin: 0;
  font-size: 14px;
  line-height: 1.35;
}

.agent-result {
  background: #b7242a;
}
</style>
