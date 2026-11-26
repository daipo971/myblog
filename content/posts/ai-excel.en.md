---
title: "How to Handle Excel with AI: Formulas, Cleaning, and Charts — the Complete Guide"
date: 2026-11-26T21:00:00+08:00
lastmod: 2026-11-26T21:00:00+08:00
draft: false
categories: ["AI Tools Hands-On"]
tags: ["Guide", "AI Office", "ChatGPT", "Kimi"]
description: "You do not need to memorise functions to manage spreadsheets: hand your Excel file to ChatGPT, Kimi, or Copilot and let AI write the formulas, clean the data, and draw the charts — with three copy-paste prompt templates and a checking list."
summary: "Excel is hard not because of the clicking, but because formulas are hard to remember, dirty data is hard to clean, and charts take forever to adjust. AI writes the formulas, cleans the data, and draws the charts; you state the rules and check the results. Three routes and three templates — follow them and you can submit the sheet."
showtoc: true
---

**The short version: the easiest division of labour for Excel with AI is — AI writes the formulas, cleans the data, and draws the charts; you state the rules and check the results.** Most people get stuck on three things, not on Excel itself: function names they cannot remember, dirty data they dare not touch, and charts that take half an hour to look right. Those three are exactly what AI is good at: tell it in one sentence what you want, and it gives you formulas you can paste, a cleaned file, and ready-made charts. But one line cannot move: the numbers are always your responsibility. Check every total AI produces against the original sheet; spot-check two or three rows of every formula by hand. Keep that division of labour in mind and this method will not go wrong.

This guide follows a simple path: first the two ways AI handles spreadsheets, then a comparison of the four common routes, then the full workflow for the three jobs — formulas, cleaning, and charts — with prompt templates you can copy directly, and finally the five most common pitfalls and questions. No jargon anywhere; any chat AI you already have, or the AI built into Excel, will do. This article is based on the products' official documentation (checked 26 November 2026), not on long-term hands-on scoring; free quotas and prices change often, so check the official links at the end before you act.

![Illustration: a laptop open on a spreadsheet with charts, a small robot assistant beside it, coffee and a notebook on the desk](/images/ai-excel/cover.webp)

## 1. First, the underlying logic: two ways AI handles spreadsheets

"Let AI do my spreadsheet" sounds like one thing, but there are really only two ways to do it. Pick the wrong one and everything after it feels awkward.

**The first way: the chat route — upload the file to a chat AI.** ChatGPT's data analysis and Kimi's spreadsheet features work like this: drag a .xlsx or .csv file into the chat, state what you need in one sentence, and AI writes code in the background, runs the calculations, and hands back the results, the charts, and a cleaned file. OpenAI's help centre puts it plainly: after you upload a well-structured table, ChatGPT can summarise rows and columns, find trends and outliers, generate tables and charts, and run Python for calculations and statistics — the arithmetic is done by code, not guessed by the model. Kimi's spreadsheet feature follows the same pattern: upload an Excel file, give instructions in plain language, and it generates formulas, cleans data, and builds pivot tables and charts, which you preview and then download.

The advantage of this route is the lowest barrier: no plug-in to install, no software to change — any AI chat that accepts file uploads will do. The disadvantage is that AI never touches your original file: it edits its own copy, and you have to download the result and overwrite the original yourself, one extra step; and once a file leaves your computer, it has to pass the privacy test first (see Section 4).

**The second way: the built-in route — AI lives inside Excel itself.** Copilot in Excel and Claude for Excel work like this: open the sidebar inside Excel and ask questions about the workbook you have open, and AI edits cells, adds formula columns, and builds charts and pivot tables on the spot. Microsoft's official documentation says Copilot in Excel can edit worksheets, generate data and formulas, and summarise across sheets, with three modes — Edit mode changes the sheet directly, Plan mode lists the steps for you to approve first, and Chat mode only answers without touching the sheet. Claude for Excel is Anthropic's official add-in: its answers carry cell references, it keeps formula relationships intact when you change an assumption, and it can explain formulas and locate errors.

The advantage of this route is that changes land on the original sheet — no importing and exporting files back and forth — which suits people who live in Excel all day. The disadvantage is the higher barrier: Copilot needs the matching Microsoft 365 subscription, Claude for Excel needs a paid Claude plan, and whether it works in China, and how to set it up, depends on your account situation first (see Section 2).

**Whichever route you take, the underlying logic is the same: AI turns your words into operations; you state the rules and check the results.** Spreadsheet work rarely fails because AI cannot do it — it fails because you did not state the rules. Does "Beijing", "Beijing City", and "BEIJING" in the region column count as the same place? Are dates summarised by month or by quarter? Only you know those rules, and if they are not in the prompt, AI can only guess — and a wrong guess comes back as a clean-looking wrong table. That is why every template in this guide makes you write the rules down first, before AI touches anything.

Related reading: if you have not decided which tool to use for data analysis, see our [AI data analysis tools compared: doing data analysis without programming](/posts/ai-data-analysis-tools-2026/) (in Chinese), which sorts the tools by scenario; for ChatGPT's versions and membership, see the [complete ChatGPT guide](/posts/chatgpt-guide/) (in Chinese); Kimi's versions, pricing, and use in China are covered in the [Kimi model guide](/posts/kimi-guide/) (in Chinese).

## 2. Four routes compared: pick the right tool before you start

The table below is based on official sources checked on 26 November 2026. Prices and free quotas change often — check the official site before you act; where availability in China is unconfirmed, this article does not claim it works.

| Route | How it works | Price (at time of checking) | Direct access in China | Best for |
| :--- | :--- | :--- | :--- | :--- |
| **ChatGPT data analysis** | Upload .xlsx/.csv in the chat, ask, download the result | Plus $20/month; free and paid plans have different upload quotas — check the entry inside your account | You need to sort out access yourself; see our [China access guide for ChatGPT, Claude, and Gemini](/posts/chatgpt-claude-gemini-china-access-guide/) (in Chinese) | Occasional spreadsheets, when you want charts and conclusions |
| **Kimi spreadsheets** | Upload a file in the chat, or open Kimi's spreadsheet and give instructions | Free to chat, quotas per the official site | Direct access in China, no extra setup | Everyday office work, when you do not want to wrestle with accounts |
| **Copilot in Excel** | Copilot panel at the bottom right of Excel, three modes that edit the sheet directly | Business add-on $30/user/month; personal Microsoft 365 includes AI credits | Depends on your Microsoft 365 subscription and region — confirm before buying | People who work in Excel all day |
| **Claude for Excel** | Official add-in sidebar, answers carry cell references | Needs a paid Claude plan, Pro from $20/month | You need to sort out access yourself; see the access guide above | Model sheets full of nested formulas, where every number needs a traceable source |

**How to choose, in one sentence each:**

- **You want the fastest start and you are in China: try Kimi first.** No account problems to solve; upload a file and start — formulas, cleaning, and charts can all be done there. DeepSeek's chat also accepts file uploads for simple analysis, the same pattern, and works as a backup.
- **You already pay for ChatGPT Plus: do not switch tools.** Upload the file and ask — data analysis is a standard ChatGPT feature, it supports .xls, .xlsx, and .csv, and it writes code, runs the calculations, and produces charts.
- **Your company provides Microsoft 365 and you live in Excel: try Copilot.** It edits the sheet in place, so no files go back and forth; ask it two questions in Chat mode first to confirm it understands your table's structure, then switch to Edit mode.
- **Your sheet is formulas inside formulas, and one wrong number breaks everything: consider Claude for Excel.** Its selling point is cell-level references and formula tracing, which fits financial models where "every number must have a source". But first confirm your Claude account and Excel version meet the official requirements (Windows needs a newer version with a Microsoft 365 subscription; Mac needs 16.46 or later).

**One warning: do not pay for three tools at once "just in case".** Run one full job through a free route you already have, confirm AI really saves you time, and only then decide whether to pay for a built-in route. For more office AI workflows in this series, see [How to Write a Weekly Report with AI: 5 Steps from a Diary to a Report You Can Submit](/en/posts/ai-weekly-report/) and [How to Make a PPT with AI: From Outline to a Deck You Can Present](/en/posts/ai-ppt-workflow/).

## 3. Hands-on: from a messy sheet to a report you can submit

Take a common sales record as the example: columns for date, region, product, quantity, unit price, and amount. Do the three jobs in order, and the result is a report you can submit.

### Step 0: First tidy the sheet so AI can read it (5 minutes, worth it)

Three things break AI's reading of a table: merged cells, multi-row headers, and several unrelated tables stuffed into one worksheet. Fix them first:

1. **Unmerge the cells**: select the range, unmerge, and fill the empty cells with the matching values.
2. **Keep one header row**: put the column names in row one (date, region, product, quantity, unit price, amount), in plain words, without units — state the unit separately, for example "amounts are in yuan".
3. **One row per record**: do not insert blank rows, total rows, or subtotal rows inside the table — let AI calculate the totals at the end.
4. **Save a copy before uploading**: leave the original file untouched and let AI work on the copy. Rename it something like `sales-records-to-process.xlsx` so you never overwrite the wrong file.

OpenAI's help centre gives the same advice: headers in row one, one row per record, column names in everyday words; do not put several unrelated tables in one worksheet, and do not put numbers you need analysed inside images.

### Task 1: Let AI write the formulas — no memorising function names

**Chat route:** upload the copy to ChatGPT or Kimi, paste the template below, and replace the bracketed parts with your own column names and needs.

```
This is a sales record table with columns: date, region, product, quantity, unit price, amount.
Please write formulas to:
1. Calculate each row's amount in column G (quantity × unit price);
2. Summarise November sales by region on a separate sheet;
3. Highlight rows where the amount is over 5000.
Give me formulas I can paste straight into Excel, and explain what each formula does, line by line — do not give results only.
```

**Copilot route:** save the file to OneDrive, open it in Excel, click the Copilot icon at the bottom right, and first ask in "Chat mode": "What columns does this table have?" Once it has the structure right, switch to "Plan mode", enter the same request, read through the steps it lists, and let it run only if the steps look right.

**How to check:** after pasting the formulas back, hand-calculate two or three rows — does quantity times unit price equal the amount in that cell? Then check the summary sheet's grand total against a SUM of the amount column in the original table. If the numbers do not match, stop before going further: paste the error message and two sample rows back to AI as they are, and ask it to explain each step of the formula.

### Task 2: Clean the dirty data — get the counts first, then let it act

The four most common kinds of dirty data: duplicate rows, the same thing written different ways (Beijing / Beijing City / BEIJING), dates in mixed formats, and empty cells. The rule for cleaning is: **make AI report the numbers first, then let it act**, so you can reconcile the result afterwards.

```
First check this table's data quality, then clean it:
1. For each column, list the data type, the number of empty cells, and the number of duplicate rows;
2. Unify "Beijing ", "Beijing City", and "BEIJING" in the "Region" column to "Beijing";
3. Unify the "Date" column to YYYY-MM-DD, and list the rows that cannot be parsed;
4. Report the total row count and the total amount before and after cleaning, so I can check them.
Give me a downloadable cleaned file, plus a list of what you changed.
```

**Key points:**

- **You set the unification rules; AI only executes them.** Whether "Beijing" and "Beijing City" count as the same place, and whether "11/5" in a date means 5 November or 11 May — those judgements go in the prompt; do not let AI guess.
- **Ask for row counts, not just "cleaned".** Get the total row count and the total amount before and after cleaning, and compare them with the original table — that tells you at once whether anything was deleted by mistake. If rows went missing, ask which rows they were and why they were removed.
- **List the unparseable rows separately.** Rows with a mistyped date or text mixed into an amount column should not be quietly fixed by AI — list them first so you can look at them yourself.

Kimi's spreadsheet skills also include ready-made quality checks (instructions such as /dataset-quality-audit) that scan a table for missing values, duplicates, outliers, and format problems and give it a score — useful for a first pass when the data is large.

### Task 3: Produce the charts and a one-sentence conclusion

Once the table is clean, the charts are a one-sentence job. But decide before charting: who is this chart for, and what question should it answer? A trend for your boss, a share breakdown for colleagues — the question decides the chart.

```
Based on this cleaned sales table:
1. Draw a bar chart by month to show the sales trend;
2. Draw a pie chart by product to show the share;
3. Summarise in three sentences: which month was highest, which product sold best, and whether there are any outliers.
The charts must be ready to drop into a weekly report, and the numbers must match the table.
```

**How to check:** if a chart's numbers do not match the table, the chart cannot be used. Check each bar of the bar chart against the monthly summary table; check that the pie chart's percentages add up to 100%. AI draws charts fast, but it will not take responsibility for your numbers — a chart is only ready for the weekly report once you have checked the figures. For how to use the chart in a weekly report, see [How to Write a Weekly Report with AI](/en/posts/ai-weekly-report/); to put the chart into slides, see [How to Make a PPT with AI](/en/posts/ai-ppt-workflow/).

## 4. Pitfalls: five mistakes that waste the whole sheet

### Pitfall 1: Do not upload a table that contains private information

Salary tables, customer tables with ID numbers and phone numbers, and unpublished company financial data should not be uploaded to any online AI chat. De-identify first: delete the name, phone, and ID columns and keep only the fields the analysis needs, or replace sensitive columns with codes. If it cannot be de-identified, process it locally with Excel's own features, or use a tool your company has approved. Before uploading, ask one question: if this table leaked, could I bear the consequences? If not, do not upload it.

### Pitfall 2: Check every total yourself

Every total, percentage, and ranking AI gives you must be checked against the original table. The simplest way: make AI report the total row count and total amount before and after cleaning every time, then SUM the original table yourself and compare — only continue when the two sides agree. If they do not match, stop and ask; do not carry a wrong number into charts and conclusions. One wrong total in a report destroys the credibility of the whole thing.

### Pitfall 3: Fix dates and merged cells before uploading

Dates are the thing AI misreads most easily: "11/5" could be 5 November or 11 May, and "2026.11.26" mixed with "2026/11/26" will split a summary in two. Unify the date column to YYYY-MM-DD before uploading. Merged cells are the same story: AI reads a merged header's structure wrong, so unmerge and fill in the blanks first. Five minutes here saves half an hour of corrections later.

### Pitfall 4: Verify formulas line by line — do not judge by how plausible the result looks

The smoother an AI-written formula looks, the more you should spot-check it. Hand-calculate two or three rows: does quantity times unit price equal the amount cell, are the summary conditions right, does the IF boundary include the equal case? Ask AI to explain each step of the formula — only a formula that is explained clearly and calculates correctly goes into the real sheet. A formula that cannot be explained should never be pasted into a formal table, however good it looks.

### Pitfall 5: Never edit the original file directly — back up first

On the chat route, remember to save a copy before uploading; on Copilot's Edit mode, first look the steps over in Plan or Chat mode and only run them once they look right. AI edits in bulk — one mistake is a whole column wrong — and with a copy in hand you can always start over. The version that goes out is always the checked one, never AI's first draft.

## 5. Summary: next time you get a messy sheet, follow this order

1. **Tidy the sheet first**: unmerge cells, one header row, one row per record, save a copy.
2. **Then pick a route**: for everyday office work, start with Kimi or ChatGPT file upload; only consider Copilot or Claude for Excel if you live in Excel all day.
3. **Formulas, cleaning, and charts in three steps**: write the rules clearly in a template for each step, and make AI report the numbers before it acts.
4. **Check last**: reconcile the totals, spot-check two or three formula rows, and match the chart numbers to the table before you submit.

The Excel work has not gone away — the division of labour has changed: you state the rules and check the results, AI writes the formulas, cleans the data, and draws the charts. Walk through it once in this order, and the next time you get a messy sheet you will know exactly where to click first. More office AI workflows in the same series: [How to Write a Weekly Report with AI](/en/posts/ai-weekly-report/) and [How to Write Meeting Notes with AI](/en/posts/ai-meeting-notes/).

## FAQ

**Can the free version of ChatGPT analyse Excel?**

It can upload files, but the free and paid plans have different upload quotas and available features — go by the actual entry inside your account. For an occasional small table, the free version is usually enough; if you do this every week and the files are large, consider Plus ($20/month, see the [complete ChatGPT guide](/posts/chatgpt-guide/) (in Chinese)).

**What if AI's formula is wrong?**

Paste the error message and two sample rows of data back to AI exactly as they are, and ask it to explain, step by step, which column each part of the formula calculates from. Most errors come from column names not matching, a wrong condition range, or dates not unified. Do not use a formula you cannot get explained; ask for another version phrased differently.

**What if the table is too big to upload?**

Delete the columns the analysis does not need and keep only the fields you use; or split the file into smaller ones by month or region and process them in batches. OpenAI's help centre notes that oversized files, over-complex structures, and too many formulas all affect processing — if a job comes back incomplete, ask AI to look at only the specified sheet, rows, or columns.

**Do these methods work with WPS Spreadsheets?**

The chat route does not care which spreadsheet software you use — the files are .xlsx either way, so a table made in WPS uploads the same way. WPS's own AI features are a different route; their functions and prices follow WPS's official site, and this article does not cover them.

**Can I do this on my phone?**

You can ask and look on a phone; editing is still a computer job. A phone is fine for a quick question such as "which month sold best in this table", but not for pasting formulas or adjusting charts. No step in this article needs a phone screenshot.

**Can I submit the numbers AI calculated as they are?**

No. Reconcile the totals first: make AI report the total row count and total amount before and after cleaning, and check them against a SUM of the original table before submitting. Numbers are the bottom line of a report, and AI does not carry that responsibility.

## Update log

- 2026-11-26: First published (English version). Based on OpenAI, Microsoft, and Kimi official documentation (checked 26 November 2026). Chinese version published the same day.

## References

- [OpenAI Help Center: "Data analysis with ChatGPT"](https://help.openai.com/en/articles/8437071-data-analysis-with-chatgpt)
- [Microsoft Support: "Get started with Copilot in Excel"](https://support.microsoft.com/en-gb/excel/copilot/get-started-with-copilot-in-excel)
- [Kimi: "What can the AI Excel assistant do? A complete guide"](https://www.kimi.ai/zh-hans/resources/ai-excel-bot)
