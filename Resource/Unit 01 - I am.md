
好的，这是严格按照我们刚才定稿的 Markdown 模版生成的 **Level 1 - Unit 01** 正式内容。

您可以直接将此文档用于 App 的数据录入或课程脚本制作。

---

# Unit Configuration [元数据]

- **Level**: Level 1 (Atomic Mode)
    
- **Module**: Module 1: The Verb "To Be" (Identity & Existence)
    
- **Unit**: Unit 01: I am... (Identity)
    
- **Topic**: Self Introduction (自我介绍)
    
- **Tags**: #Grammar/Be #Scenario/Office #Vocabulary/Basic
    

---

## Part 1: The Source Code [课文内容]

### Text (英文原文)

> Hello, everyone.
> 
> My name **is** David.
> 
> I **am** a new programmer.
> 
> I **am** from Shanghai.
> 
> I **am** happy to be here.
> 
> I **am** ready for the new job.

### Translation (中文参考)

大家好。

我的名字是 David。

我是一名新来的程序员。

我来自上海。

很高兴能来到这里。

我已经为这份新工作准备好了。

---

## Part 2: Vocabulary Library [核心词汇库]

### 1. programmer /ˈprəʊɡræmə(r)/ /ˈproʊɡræmər/ (n. 程序员)

- **Definition**: A person who writes computer programs.
    
- **Example**:
    
    - En: I am a Python **programmer**.
        
    - Cn: 我是一名 Python 程序员。
        
- **Collocations (核心搭配)**:
    
    - a computer programmer (电脑程序员)
        
    - a senior programmer (高级程序员)
        
- **Logic Note (逻辑/助记)**:
    
    - 后缀 `-er` 通常代表“人”或“执行者”（Worker/Driver）。
        

### 2. new /njuː/ /nuː/ (adj. 新的)

- **Definition**: Not existing before; introduced recently.
    
- **Example**:
    
    - En: The car is **new**.
        
    - Cn: 这辆车是新的。
        
- **Collocations (核心搭配)**:
    
    - new to... (对...来说是新来的) -> _I am new to this city._
        
    - brand new (全新的)
        
- **Logic Note (逻辑/助记)**:
    
    - 它是一个属性值 (Attribute)，用来修饰名词。`Programmer(status="new")`。
        

### 3. ready /ˈredi/ /ˈredi/ (adj. 准备好的)

- **Definition**: Fully prepared for something.
    
- **Example**:
    
    - En: Dinner is **ready**.
        
    - Cn: 晚饭做好了。
        
- **Collocations (核心搭配)**:
    
    - be ready for sth (为某事做好准备)
        
    - be ready to do sth (准备好做某事)
        
- **Logic Note (逻辑/助记)**:
    
    - 这是一种“状态 (State)”。必须配合 be 动词使用 -> `I am ready`. (不能说 I ready)。
        

### 4. happy /ˈhæpi/ /ˈhæpi/ (adj. 高兴的)

- **Definition**: Feeling or showing pleasure.
    
- **Example**:
    
    - En: I am very **happy** today.
        
    - Cn: 我今天很高兴。
        
- **Collocations (核心搭配)**:
    
    - happy to do sth (很高兴做某事)
        
    - happy about sth (对某事感到高兴)
        

---

## Part 3: Syntax Parsing [句型结构精读]

- **Target Sentence 1**: I **am** a new **programmer**.
    
- **Structure Visualization**:
    
    - `[Subject (I)]` + `[Link Verb (am)]` + `[Complement (a new programmer)]`
        
- **Analysis (程序员视角讲解)**:
    
    1. **赋值操作**：这里的 `am` 就是一个等号 `=`。逻辑是 `I = programmer`。
        
    2. **类型匹配**：因为 `programmer` 是一个可数名词（Countable Noun），且是单数，所以必须给它分配一个空间，必须加冠词 `a`。
        
    3. **修饰层级**：`new` 是修饰 `programmer` 的，它们打包在一起作为一个整体（名词短语），赋给 `I`。
        
- **Target Sentence 2**: I **am** ready for the new job.
    
- **Structure Visualization**:
    
    - `[Subject (I)]` + `[Link Verb (am)]` + `[Adjective (ready)]` + `[Preposition Phrase (for the new job)]`
        
- **Analysis (程序员视角讲解)**:
    
    1. **状态定义**：`ready` 是一个形容词。在英语中，形容词不能独立做谓语，必须挂载在 `be` 动词后面。
        
    2. **参数配置**：`for the new job` 是介词短语，用来解释“为什麽准备好了”。它是 `ready` 的配置参数。
        

---

## Part 4: Grammar Logic [核心语法逻辑]

### Theme: The Verb "To Be" (Assignment Operator)

**1. The Logic (底层逻辑)**

**Be动词 (am/is/are)** 是英语世界里的**“赋值符号” (=)**。它不表示任何具体的动作（如跑、跳、吃），它只负责连接“主语”和它的“身份/状态”。

- `I am David.` -> `I` 的值是 `David`。
    
- `I am happy.` -> `I` 的当前状态是 `happy`。
    

**2. Pattern & Formula (公式图解)**

- **Formula**: `Subject` + **`am/is/are`** + `Noun/Adjective`
    
- **Matching Rule (匹配规则)**:
    
    - **I** + **am** ... (专用接口)
        
    - **He/She/It** + **is** ... (单数接口)
        
    - **You/We/They** + **are** ... (复数接口)
        

**3. Examples from Text (文中例句)**

- _Identity (身份)_: I **am** a new programmer.
    
- _Origin (来源)_: I **am** from Shanghai.
    
- _Emotion (情绪)_: I **am** happy.
    

**4. ⚠️ Common Bug (常见错误警示)**

- **Bug 1**: 缺少连接符 (Missing Operator)
    
    - ❌ _Wrong_: I ready. (我准备好了)
        
    - ✅ _Right_: I **am** ready.
        
    - _Fix_: 形容词做不了谓语（Main Function），必须加 `am`。
        
- **Bug 2**: 动词冲突 (Double Verb Error)
    
    - ❌ _Wrong_: I am work here. (我在这里工作)
        
    - ✅ _Right_: I **work** here.
        
    - _Fix_: `work` 已经是动作了，不需要赋值符号 `am`。不要画蛇添足。


---

## Part 5: Extensive Reading (Expansion) [泛读扩展]

### 1. Scenario (场景设定)
**Subject**: Sarah, a graphic designer. (平面设计师 Sarah)
**Context**: Sarah introduces herself and her studio. (Sarah 介绍自己和她的工作室)

### 2. The Text (泛读文章)
> Hello. My name **is** Sarah.
> I **am** a graphic designer.
> My studio **is** small, but it **is** very cool.
> I **am** creative and active.
> My designs **are** colorful.
> I **have** a sketchbook on the table.
> I **like** art and music.
> I **am** busy today, but I **am** fine.

### 3. Translation (参考译文)
你好。我的名字是 Sarah。
我是一名平面设计师。
我的工作室很小，但它非常酷。
我是充满创意且活跃的。
我的设计是多彩的。
我的桌子上有一本素描本。
我喜欢艺术和音乐。
我今天很忙，但我状态不错。

### 4. Vocabulary Supplement (补充词汇)
*在此场景中出现的新词，仅需认知即可*

* **designer** (n. 设计师)
* **studio** (n. 工作室/画室)
* **cool** (adj. 酷的/绝妙的)
* **creative** (adj. 有创造力的)
* **active** (adj. 活跃的/积极的)
* **colorful** (adj. 多彩的/颜色丰富的)
* **sketchbook** (n. 素描本/速写本)
* **art** (n. 艺术)



---

### 🧩 App 完整关卡逻辑 (User Flow Summary)

结合你补充的逻辑，这是 Unit 01 在 App 里的最终形态：

1. **Step 1: Intensive Study (精读闯关)**
* 观看 Part 4 (语法逻辑) + Part 3 (句法拆解)。
* 学习 Part 2 (核心词汇 `programmer`, `modern`...)。
* 朗读 Part 1 (David 的文章)。


2. **Step 2: Extensive Practice (泛读巩固)**
* 进入 Part 5 (Sarah 的文章)。
* **任务**：在不看翻译的情况下读懂文章。遇到生词点按查看 Part 5 的词汇表。
* **目的**：验证是否真的掌握了 `am/is` 和 `like/have` 的区别（换了个马甲是否还认识）。


3. **Step 3: Unit Test (解锁测试)**
* **Quiz 1 (Grammar)**: 选词填空 -> *I ___ a designer. (am/is/are)*
* **Quiz 2 (Vocab)**: 听音选义 -> *programmer / creative*.
* **Quiz 3 (Syntax)**: 排序组句 -> *is / office / The / big*.
* **判定**：正确率 > 80% -> **Unlock Unit 02**.
