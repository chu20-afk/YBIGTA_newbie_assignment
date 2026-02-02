# 1. Prompting 방법별 성능 비교 (Accuracy)

GSM8K 데이터셋(총 50문항)을 사용하여 Direct Prompting, Chain-of-Thought(CoT) Prompting, 그리고 직접 설계한 My Prompting 기법의 성능을 비교하였다.
각 프롬프트 기법에 대해 0-shot, 3-shot, 5-shot 설정에서의 정답률(Accuracy)은 다음과 같다.

Prompting Method	0-shot	3-shot	5-shot
Direct Prompting	72%	82%	74%
CoT Prompting	82%	80%	74%
My Prompting	74%	76%	80%

# 2. CoT Prompting이 Direct Prompting보다 효과적일 수 있는 이유

Direct Prompting은 문제에 대해 바로 최종 답변을 생성하도록 유도한다.
이 방식은 간단한 문제에서는 효율적일 수 있지만, 다단계 추론이 필요한 수학 문제에서는 중간 추론 과정이 생략되면서 오류가 발생할 가능성이 높다.

반면 Chain-of-Thought(CoT) Prompting은 모델이 문제를 단계별로 분해하여 reasoning 과정을 명시적으로 생성하도록 유도한다.
이로 인해 다음과 같은 장점이 있다.

1) 문제를 여러 단계로 나누어 계산하므로 중간 오류를 스스로 교정할 가능성이 높다.
2) 계산 순서를 명확히 유지함으로써 복합적인 수식 문제에 더 강건한 추론을 수행한다.
3) 특히 GSM8K와 같은 수학 추론 데이터셋에서 reasoning 능력을 효과적으로 끌어낼 수 있다.

실험 결과에서도 CoT Prompting은 0-shot 설정에서 Direct Prompting보다 높은 성능(82% vs 72%)을 보였으며,
이는 추론 과정을 명시적으로 요구하는 것이 모델의 잠재 성능을 끌어내는 데 도움이 됨을 보여준다.

# 3. My Prompting이 CoT Prompting보다 더 효과적일 수 있는 이유

본 실험에서 설계한 My Prompting 기법은 단순히 “생각 과정을 써라”는 CoT 방식에서 한 단계 더 나아가,
모델의 출력 구조와 사고 흐름을 더 강하게 제어하는 데 초점을 두었다.

My Prompting의 주요 특징은 다음과 같다.

1) 문제 해결 과정을 일정한 형식(문제 이해 → 계산 → 최종 답)으로 유도하여 추론의 일관성을 높였다.

2) 불필요하게 장황한 reasoning을 줄이고, 핵심 계산 단계에 집중하도록 설계하였다.

3) few-shot 예시를 통해 “정답에 도달하는 사고 패턴”을 명확히 학습하도록 유도하였다.

그 결과, 5-shot 설정에서 My Prompting은 80%의 정답률을 기록하여
동일 조건의 Direct Prompting(74%)과 CoT Prompting(74%)을 모두 상회하였다.

이는 단순히 reasoning을 많이 출력하게 하는 것보다,
어떤 방식으로 reasoning을 구조화하느냐가 성능에 더 중요한 요소가 될 수 있음을 시사한다.

# 4. 결론

본 실험을 통해 다음과 같은 결론을 얻을 수 있었다.

Direct Prompting은 간단하고 빠르지만, 복잡한 추론 문제에서는 한계가 존재한다.

CoT Prompting은 추론 과정을 명시적으로 유도함으로써 전반적인 성능 향상에 기여한다.

My Prompting은 CoT의 장점을 유지하면서도 출력 구조를 제어함으로써 특정 조건(특히 5-shot)에서 가장 높은 성능을 달성하였다.

이를 통해 프롬프트 설계에서 중요한 것은 단순한 shot 수 증가가 아니라,
모델이 문제를 “어떻게 생각하게 할 것인가”에 대한 구조적 설계임을 확인할 수 있었다.