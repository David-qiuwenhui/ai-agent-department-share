<template>
  <div class="demo-wrap">
    <div class="scenario-bar">
      <div>
        <span class="bar-label">演示任务</span>
        <b>用户想对比两条电子流，确认当前节点、关键字段和异常差异</b>
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
    title: "输入电子流编号",
    desc: "用户分别输入两条电子流编号，系统按固定字段查询。",
    output: "查到两条电子流的基础状态，但还没有形成差异判断。"
  },
  {
    title: "返回标准信息表",
    desc: "展示当前节点、处理人、发起时间、关键字段等固定信息。",
    output: "用户拿到两张表，需要自己判断节点、字段和状态差异。"
  },
  {
    title: "按规则标红异常",
    desc: "根据预设规则标记超时、状态不一致、字段缺失等问题。",
    output: "规则内问题可以识别；如果需要解释原因，还要人工继续追查。"
  }
];

const agentSteps = [
  {
    tag: "计划",
    title: "先理解对比目标",
    desc: "判断用户不是单纯查状态，而是要找差异、原因和下一步动作。",
    output: "形成对比维度：节点、处理人、关键字段、停留时长、异常原因。"
  },
  {
    tag: "工具",
    title: "查询多类上下文",
    desc: "读取电子流详情、流转日志、字段变更记录和相关处理规则。",
    output: "发现一条停在复核节点，另一条已进入归档节点。"
  },
  {
    tag: "观察",
    title: "发现信息不足",
    desc: "发现用户没有说明是否只看当前状态，还是要追溯全流程差异。",
    output: "提出澄清问题，并先给出基于当前节点的临时结论。"
  },
  {
    tag: "调整",
    title: "补充分析路径",
    desc: "补查历史节点和字段版本，把差异拆成状态差异和字段差异。",
    output: "定位到差异来自审批节点回退，以及一个字段取值未同步。"
  },
  {
    tag: "交付",
    title: "输出可复核结论",
    desc: "给出差异摘要、证据来源、待确认项和建议处理动作。",
    output: "Agent 的价值不是替人查一张表，而是把查询推进到可判断状态。"
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
  border: 1px solid rgba(0, 0, 0, 0.08);
  border-radius: 8px;
  box-shadow: 0 18px 42px rgba(0, 0, 0, 0.06);
}

.scenario-bar b {
  display: block;
  color: #1d1d1f;
  font-size: 18px;
  line-height: 1.35;
}

.bar-label {
  color: #86868b;
  font-size: 13px;
  font-weight: 760;
}

.demo-controls {
  display: flex;
  gap: 8px;
  flex: 0 0 auto;
}

.demo-controls button {
  height: 34px;
  padding: 0 12px;
  border: 1px solid rgba(0, 0, 0, 0.12);
  border-radius: 8px;
  background: #fff;
  color: #1d1d1f;
  font-weight: 720;
  font-size: 13px;
  cursor: pointer;
}

.demo-controls button.primary {
  border-color: #0071e3;
  background: #0071e3;
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
  border: 1px solid rgba(0, 0, 0, 0.08);
  border-radius: 8px;
  box-shadow: 0 18px 42px rgba(0, 0, 0, 0.06);
}

.lane header {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  padding-bottom: 10px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.08);
}

.lane header span {
  color: #0071e3;
  font-size: 15px;
  font-weight: 760;
}

.lane header b {
  color: #1d1d1f;
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
  border: 1px solid rgba(0, 0, 0, 0.08);
  border-radius: 8px;
  background: #f5f5f7;
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
  border-color: rgba(0, 113, 227, 0.3);
  background: #f7fbff;
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
  border-radius: 8px;
  background: #1d1d1f;
  color: #fff;
  font-style: normal;
  font-size: 13px;
  font-weight: 760;
}

.trace-list i {
  width: 46px;
}

.step-list b,
.trace-list b {
  display: block;
  color: #1d1d1f;
  font-size: 15px;
  margin-bottom: 3px;
}

.step-list p,
.trace-list p {
  color: #6e6e73;
  font-size: 13px;
  line-height: 1.35;
  margin: 0;
}

.agent-lane {
  border-color: rgba(0, 113, 227, 0.22);
}

.agent-loop {
  display: grid;
  grid-template-columns: repeat(5, minmax(0, 1fr));
  gap: 8px;
}

.loop-node {
  text-align: center;
  padding: 8px 6px;
  border: 1px solid rgba(0, 0, 0, 0.08);
  border-radius: 8px;
  background: #f5f5f7;
  color: #6e6e73;
  font-size: 13px;
  font-weight: 760;
}

.loop-node.active {
  border-color: #0071e3;
  background: #0071e3;
  color: #fff;
}

.lane-result {
  min-height: 54px;
  padding: 11px 13px;
  border-radius: 8px;
  background: #1d1d1f;
  color: #fff;
}

.lane-result span {
  display: block;
  color: #a1a1a6;
  font-size: 12px;
  font-weight: 760;
  margin-bottom: 4px;
}

.lane-result p {
  margin: 0;
  font-size: 14px;
  line-height: 1.35;
}

.agent-result {
  background: #0071e3;
}
</style>
