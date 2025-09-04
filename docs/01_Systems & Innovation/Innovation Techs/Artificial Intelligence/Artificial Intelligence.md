## 1. ARTIFICIAL INTELLIGENCE  
### 1.1. Introduction to AI  
- Definition:  
  Lĩnh vực của khoa học máy tính nhằm tạo ra hệ thống có khả năng **suy luận, học hỏi, lập kế hoạch, nhận diện, và ra quyết định** – giống hoặc vượt con người.  

- Mục tiêu:  
  - Xây dựng máy thông minh (rational agents)  
  - Tự động hóa các nhiệm vụ trí tuệ  
  - Hiểu bản chất của trí thông minh  

- Các tiếp cận:  
  - **Thinking humanly**: Mô phỏng tư duy con người (cognitive modeling)  
  - **Acting humanly**: Đạt hành vi giống con người (Thử nghiệm Turing)  
  - **Thinking rationally**: Suy luận logic (logic-based AI)  
  - **Acting rationally**: Hành động tối ưu dựa trên môi trường (rational agent)  

- Thử nghiệm Turing (Turing Test):  
  - Máy vượt qua nếu người phỏng vấn không phân biệt được nó với con người qua hội thoại.  
  - Yêu cầu: xử lý ngôn ngữ, kiến thức chung, học, suy luận.  

### 1.2. Foundations of AI  
- Toán học:  
  - Logic, xác suất, đại số tuyến tính, giải tích  
- Khoa học máy tính:  
  - Cấu trúc dữ liệu, thuật toán, học máy  
- Ngữ văn & Ngôn ngữ học:  
  - Xử lý ngôn ngữ tự nhiên (NLP)  
- Tâm lý học & Triết học:  
  - Mô hình tư duy, nhận thức  
- Thần kinh học:  
  - Mạng nơ-ron sinh học → cảm hứng cho ANN  
- Kinh tế học:  
  - Lý thuyết quyết định, lý thuyết trò chơi  

### 1.3. Intelligent Agents  
- **Agent**: Thực thể cảm nhận môi trường qua **cảm biến (sensors)** và hành động qua **cơ cấu chấp hành (actuators)**.  
- **Rational Agent**: Hành động để **tối đa hóa hiệu suất (performance measure)** dựa trên:  
  - Kinh nghiệm (percept sequence)  
  - Kiến thức  
  - Mục tiêu  

- Môi trường (PEAS):  
  - **P**erformance measure  
  - **E**nvironment  
  - **A**ctuators  
  - **S**ensors  

- Loại môi trường:  
  - Fully vs Partially Observable  
  - Deterministic vs Stochastic  
  - Episodic vs Sequential  
  - Static vs Dynamic  
  - Discrete vs Continuous  
  - Single-agent vs Multi-agent  

- Loại Agent:  
  - Simple Reflex  
  - Model-Based Reflex  
  - Goal-Based  
  - Utility-Based  
  - Learning Agent  

### 1.4. Problem Solving by Search  
- **State Space**: Tập hợp các trạng thái có thể có.  
- **Initial State**, **Goal Test**, **Actions**, **Transition Model**, **Path Cost**  

- **Uninformed Search (Blind Search)**:  
  - Không có thông tin về khoảng cách đến đích.  
  - BFS (Breadth-First Search):  
    - Tìm theo mức, tối ưu nếu cost = 1  
    - Độ phức tạp: O(b^d)  
  - DFS (Depth-First Search):  
    - Tìm sâu, tiết kiệm bộ nhớ  
    - Không tối ưu, có thể không hội tụ  
  - Uniform-Cost Search (UCS):  
    - Mở rộng node có cost thấp nhất → tối ưu  
  - Iterative Deepening Search (IDS):  
    - Kết hợp BFS và DFS → tối ưu và tiết kiệm bộ nhớ  

- **Informed Search (Heuristic Search)**:  
  - Dùng hàm heuristic h(n): ước lượng chi phí từ n đến đích  
  - A* Search:  
    - f(n) = g(n) + h(n)  
    - Tối ưu nếu h(n) là **admissible** (không overestimate) và **consistent**  
  - Greedy Best-First Search:  
    - f(n) = h(n) → nhanh nhưng không tối ưu  
  - IDA* (Iterative Deepening A*): Tiết kiệm bộ nhớ  

- **Local Search**:  
  - Dùng cho bài toán tối ưu hóa (không cần đường đi)  
  - Hill Climbing:  
    - Cục bộ tối ưu → dễ bị local maxima  
  - Simulated Annealing:  
    - Cho phép đi xuống → tránh local optima  
  - Genetic Algorithms:  
    - Lai ghép, đột biến, chọn lọc → tìm kiếm toàn cục  

### 1.5. Adversarial Search (Trò chơi)  
- Minimax Algorithm:  
  - Giả sử đối thủ chơi tối ưu  
  - Max (agent) chọn nước đi tốt nhất, Min (opponent) phản công tốt nhất  
- Alpha-Beta Pruning:  
  - Cắt tỉa cây minimax → giảm thời gian, không ảnh hưởng kết quả  
- Evaluation Function:  
  - Ước lượng giá trị trạng thái (thay vì đi đến cuối)  
  - Ví dụ: chess → material + position + mobility  
- Horizon Effect:  
  - Cắt cây ở độ sâu cố định → bỏ lỡ nước đi quan trọng sau đó  
- Monte Carlo Tree Search (MCTS):  
  - Dùng trong Go, AlphaGo  
  - Bốn bước: Selection, Expansion, Simulation, Backpropagation  

### 1.6. Knowledge Representation & Logic  
- **Propositional Logic**:  
  - Biểu thức: P ∧ Q → R  
  - Truth tables, inference rules (Modus Ponens)  
- **First-Order Logic (FOL)**:  
  - Có lượng từ: ∀ (toàn thể), ∃ (tồn tại)  
  - Ví dụ: ∀x Cat(x) → Mammal(x)  
- **Inference**:  
  - Resolution, Forward/Backward Chaining  
  - Unification (kết hợp biến)  

- **Ontology**:  
  - Mô hình hóa kiến thức (ví dụ: WordNet, Cyc)  
- **Semantic Networks**, **Frames**, **Description Logics**  

### 1.7. Planning  
- **STRIPS**: Ngôn ngữ mô tả hành động (precondition, effect)  
- **Situation Calculus**: Biểu diễn thay đổi trạng thái  
- **Partial Order Planning (POP)**: Không yêu cầu thứ tự tuyệt đối  
- **Hierarchical Task Network (HTN)**: Lập kế hoạch theo cấp độ  
- **GraphPlan**: Dùng đồ thị để tìm kế hoạch nhanh  

### 1.8. Uncertainty & Probabilistic Reasoning  
- **Bayes’ Theorem**:  
  $$
  P(H|E) = \frac{P(E|H) \cdot P(H)}{P(E)}
  $$
- **Bayesian Networks**:  
  - Đồ thị có hướng, không chu trình (DAG)  
  - Mô hình phụ thuộc xác suất giữa các biến  
  - Inference: tính xác suất hậu nghiệm  
- **Markov Models**:  
  - **HMM (Hidden Markov Model)**: Chuỗi trạng thái ẩn, quan sát được  
    - Dùng trong nhận dạng tiếng nói, sinh học  
    - Algorithms: Forward, Viterbi, Baum-Welch  
  - **Markov Decision Process (MDP)**:  
    - Mô hình ra quyết định trong môi trường ngẫu nhiên  
    - Components: States, Actions, Transition Probabilities, Reward  
    - Goal: Tìm chính sách (policy) tối ưu π*  
- **Partially Observable MDP (POMDP)**:  
  - Agent không biết trạng thái hiện tại → phải duy trì belief state  

### 1.9. Machine Learning (Học máy)  
- **Supervised Learning**:  
  - Input: (x, y) → học hàm f: x → y  
  - Classification (y rời rạc): SVM, Decision Tree, Neural Networks  
  - Regression (y liên tục): Linear Regression, Random Forest  
- **Unsupervised Learning**:  
  - Không có nhãn → tìm cấu trúc ẩn  
  - Clustering: K-Means, Hierarchical, DBSCAN  
  - Dimensionality Reduction: PCA, t-SNE  
- **Reinforcement Learning (RL)**:  
  - Agent học qua thử-sai, nhận phần thưởng  
  - MDP/POMDP framework  
  - Q-Learning: Cập nhật Q(s,a) = r + γ max Q(s',a')  
  - Deep Q-Network (DQN), Policy Gradients, A3C, PPO  
- **Semi-supervised & Self-supervised Learning**  
- **Transfer Learning**: Dùng kiến thức từ nhiệm vụ cũ cho nhiệm vụ mới  

### 1.10. Neural Networks & Deep Learning  
- **Perceptron**: Nơ-ron đơn giản, hàm kích hoạt step  
- **Multilayer Perceptron (MLP)**: Mạng nơ-ron truyền thẳng  
  - Forward pass, Backpropagation, Gradient Descent  
- **Activation Functions**:  
  - Sigmoid, Tanh, ReLU, Leaky ReLU, Softmax  
- **Loss Functions**:  
  - MSE (regression), Cross-Entropy (classification)  
- **Optimizers**:  
  - SGD, Momentum, RMSProp, Adam  

- **CNN (Convolutional Neural Network)**:  
  - Dùng cho ảnh, video  
  - Lớp: Conv, Pooling, FC  
  - Architectures: LeNet, AlexNet, ResNet, EfficientNet  
- **RNN (Recurrent Neural Network)**:  
  - Xử lý chuỗi (text, speech)  
  - LSTM, GRU → giải quyết vanishing gradient  
- **Transformer**:  
  - Attention mechanism (Self-Attention)  
  - Không cần recurrence → song song hóa tốt  
  - Dùng trong BERT, GPT, T5  
- **Autoencoders**:  
  - Mạng nén và tái tạo dữ liệu → học biểu diễn  
- **GAN (Generative Adversarial Network)**:  
  - Generator vs Discriminator → tạo dữ liệu mới (ảnh, âm thanh)  

### 1.11. Natural Language Processing (Xử lý ngôn ngữ tự nhiên)  
- Tokenization, Stemming, Lemmatization  
- POS Tagging, Parsing, NER  
- Word Embeddings:  
  - Word2Vec, GloVe, FastText  
- Language Models:  
  - N-gram, Neural LM (RNN, Transformer)  
- Machine Translation:  
  - Seq2Seq, Attention, Transformer  
- Sentiment Analysis, Text Summarization, Question Answering  
- BERT, GPT, LLaMA: Mô hình ngôn ngữ lớn (LLM)  

### 1.12. Computer Vision  
- Image Classification, Object Detection (YOLO, SSD, Faster R-CNN)  
- Semantic Segmentation, Instance Segmentation  
- Pose Estimation, Face Recognition  
- Optical Flow, 3D Reconstruction  
- Vision Transformers (ViT)  

### 1.13. Robotics  
- Perception (sensors: camera, lidar, IMU)  
- Localization (SLAM: Simultaneous Localization and Mapping)  
- Path Planning (A*, RRT)  
- Control (PID, MPC)  
- Human-Robot Interaction  

### 1.14. Ethics & AI Safety  
- Bias in AI (gender, race)  
- Explainability (XAI)  
- Privacy (dữ liệu cá nhân)  
- Autonomous weapons  
- Superintelligence & Alignment Problem  
- Fairness, Accountability, Transparency (FAT)  

### 1.15. AI Applications  
- Healthcare: Chẩn đoán, phát hiện bệnh  
- Finance: Dự đoán, giao dịch tự động  
- Autonomous Vehicles: Xe tự lái  
- Recommendation Systems: Netflix, Amazon  
- Game AI: AlphaGo, Dota 2 bots  
- Virtual Assistants: Siri, Alexa, ChatGPT  

---

:::note Artificial Intelligence
Artificial Intelligence is the science and engineering of making intelligent machines, especially  
intelligent computer programs. It is related to the similar task of using computers to understand  
human intelligence, but AI does not have to confine itself to methods that are biologically observable.

Core pillars:
- **Search & Planning**: Finding optimal paths and actions.
- **Knowledge & Reasoning**: Representing and inferring facts.
- **Uncertainty**: Handling incomplete or noisy information.
- **Learning**: Adapting from data (ML, DL).
- **Perception & Action**: Seeing, speaking, moving (NLP, CV, Robotics).

Modern AI is driven by:
- **Deep Learning** and **Large Language Models**.
- **Big Data** and **Computational Power** (GPUs, TPUs).
- **Reinforcement Learning** for autonomous decision-making.

AI is transforming every industry, but must be developed responsibly.
:::

## Formulas

                        ARTIFICIAL INTELLIGENCE
                                 |
        ---------------------------------------------------------
        |                        |                              |
    SEARCH & PLANNING      LEARNING & ML                REASONING & LOGIC
        |                        |                              |
   ---------------       -------------------         ---------------------
   |      |      |       |        |        |         |         |         |
BFS/DFS  A*     Minimax  Supervised  Unsupervised  Reinforcement  Logic  Bayes  MDP
                 MCTS     Neural Nets  Clustering  Q-Learning     FOL   Networks  POMDP

1. **Bayes' Theorem**  
   $$
   P(H|E) = \frac{P(E|H) \cdot P(H)}{P(E)}
   $$

2. **Entropy (Information Theory)**  
   $$
   H(X) = -\sum_{i} P(x_i) \log_2 P(x_i)
   $$

3. **Information Gain (ID3, C4.5)**  
   $$
   \text{IG}(S,A) = H(S) - \sum_{v \in \text{Values}(A)} \frac{|S_v|}{|S|} H(S_v)
   $$

4. **Q-Learning Update Rule**  
   $$
   Q(s,a) \leftarrow Q(s,a) + \alpha [r + \gamma \max_{a'} Q(s',a') - Q(s,a)]
   $$

5. **Softmax Function**  
   $$
   \sigma(z)_i = \frac{e^{z_i}}{\sum_{j} e^{z_j}}
   $$

6. **Cross-Entropy Loss**  
   $$
   L = -\sum_{i} y_i \log(\hat{y}_i)
   $$

7. **Bellman Equation (MDP)**  
   $$
   V^\pi(s) = \sum_{a} \pi(a|s) \sum_{s'} P(s'|s,a) [R(s,a,s') + \gamma V^\pi(s')]
   $$

---

## Rules of Thumb

### The 80/20 Rule (AI Development)
> 80% of time is spent on data cleaning and preparation, 20% on modeling.

### No Free Lunch Theorem
> Không có thuật toán học máy nào tốt nhất cho mọi bài toán.

### Bias-Variance Tradeoff
> Underfitting (high bias) vs Overfiting (high variance). Use validation to balance.

### Occam's Razor
> Giữa các mô hình có hiệu suất tương đương, chọn mô hình đơn giản hơn.

### Feature Engineering Rule
> "Better features than better algorithms" — đặc trưng tốt quan trọng hơn thuật toán.

### AI Hype Cycle
> Mọi công nghệ AI đều trải qua: Overhype → Disillusionment → Practical Use.

### Explainability Rule
> Trong y tế, tài chính: mô hình giải thích được quan trọng hơn độ chính xác tuyệt đối.

### Data Rule
> "Garbage in, garbage out" — dữ liệu xấu → mô hình xấu.