[基本语法](https://markdown.com.cn/basic-syntax/) <br> [扩展语法](https://markdown.com.cn/extended-syntax/) <br> [表情包](https://gist.github.com/rxaviers/7360908):blush: :white_check_mark: :heavy_check_mark:  :ballot_box_with_check:

### 基本语法 :white_check_mark:
---
这些是 John Gruber 的原始设计文档中列出的元素。所有 Markdown 应用程序都支持这些元素。
| 元素          | Markdown 语法 |
| ------------ | ------------ |
| 标题（Heading）| # H1 <br> ## H2 <br> ### H3|
| **粗体**（Bold） | \*\*bold text\*\*        |
| *斜体*（Italic） |  \*italicized text\*      \_italicized text_  |
|引用块（Blockquote）|> blockquote  |
|有序列表（Ordered List）|1. First item <br> 2. Second item <br> 3. Third item |
|无序列表（Unordered List）|- First item <br>  - Second item <br>  - Third item|
|代码（Code）|\`code\`|
|分隔线（Horizontal Rule）|---|
|链接（Link）|\[title\](https://www.example.com)|
|图片（Image）	|\!\[alt text\](image.jpg)|
|下标 (Subscript )	|This is a **\<sub>subscript</sub>** text|
|上标 (Superscript )	|This is a **\<sup>superscript</sup>** text|
|下划线 (Underline )	|This is an **\<ins>underlined</ins>>** text|

### 扩展语法 :white_check_mark:
---
这些元素通过添加额外的功能扩展了基本语法。但是，并非所有 Markdown 应用程序都支持这些元素。

| 元素          | Markdown 语法 |
| ------------ | ------------ |
|表格（Table）| \| Syntax      \| Description \| <br> \| ----------- \| ----------- \| <br> \| Header      \|  Title       \| <br> \| Paragraph   \| Text        \| |
|代码块（Fenced Code Block）| \`\`\`<br> { <br>   "firstName": "John", <br> "lastName": "Smith", <br> "age": 25 <br> }<br> \`\`\`|
|脚注（Footnote）|Here's a sentence with a footnote. [^1] <br> [^1]: This is the footnote.|
|标题编号（Heading ID）|### My Great Heading \{#custom-id}|
|定义列表（Definition List）|term<br>: definition|
|删除线（Strikethrough）|\~~The world is flat.~~|
|任务列表（Task List）|- [x] Write the press release<br>- [ ] Update the website<br>- [ ] Contact the media|

### 代码块缩进&换行 :white_check_mark:
---
*代码块的三个点需要前后对齐*  
Ctrl :heavy_plus_sign:  ]   :arrow_forward:  整体右移;  
Ctrl :heavy_plus_sign:  [   :arrow_forward:  整体左移；  
`<br>`或者结尾双空格都可以换行。



### 字体颜色 不支持 :negative_squared_cross_mark:
---



## Alert :white_check_mark:


> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.
