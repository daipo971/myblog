---
title: "How to Write Meeting Notes with AI: 5 Steps from Recording to Minutes You Can Send to the Group"
date: 2026-11-26T16:00:00+08:00
lastmod: 2026-11-26T16:00:00+08:00
draft: false
categories: ["AI Tools Hands-On"]
tags: ["Guide", "AI Office", "Meeting Notes", "Kimi"]
description: "The full AI meeting-notes workflow: set the agenda before the meeting, record it, transcribe it, then let AI organise it — with three copy-paste prompt templates and three scenario playbooks."
summary: "Meeting notes are hard not because of the typing, but because you have to listen, sort out who said what, and settle who is responsible for what — all at once. AI turns the recording into text and the spoken words into structure; you check the names, numbers, and action items. Five steps and three templates, and you can send it to the group."
showtoc: true
---

**The short version: the hardest part of meeting notes is not the typing — it is doing three things at once: hearing everything, sorting it out, and assigning responsibility.** When a meeting ends, you need to remember who said what, what was decided, who is responsible, and by when. Take notes by hand and you miss the next sentence while writing down the last one; rely on memory and half of it is gone ten minutes after the meeting ends. This is exactly what AI is good at: turning a recording into text, arranging spoken words into structure, and collecting the discussion into action items. But two things AI cannot do for you: the facts themselves — it cannot tell apart two people with the same-sounding name, and it cannot work out a number you never stated clearly — and the judgement — which remarks belong in the notes and which were only meant to be understood in the room is for you to decide. Keep this division of labour in mind and this method will not go wrong.

This guide follows a simple path: first the right division of labour, then a five-step workflow, then three prompt templates you can copy directly and three scenario playbooks, and finally the most common pitfalls and questions. No jargon anywhere; any chat AI you already have, plus your meeting software's built-in features, will do.

![Illustration: several people sitting around a meeting table, with a laptop and a phone recording on the table, and tidy meeting notes on the screen](/images/ai-meeting-notes/cover.webp)

## 1. The division of labour: what AI can do, and what it cannot

Most people are disappointed the first time they use AI for meeting notes, and the reason is not the tool — it is the wrong division of labour. Settle this table first; every step below follows it.

| Step | Who does it | Why |
| --- | --- | --- |
| Deciding what to record and what to leave out | You | AI does not know which remark was a joke and which was a decision; writing it wrong is worse than not writing it |
| Turning speech into text | AI | Transcription is a machine's strength — an hour-long meeting becomes a full transcript in minutes |
| Arranging spoken words into structure | AI | Splitting into sections, pulling out key points, and extracting action items is a language model's steadiest work |
| Checking names, numbers, and dates | You | AI will misspell a same-sounding name and mishear a number; one wrong number destroys the credibility of the whole note |
| Deciding who owns an action item and by when | You | If the owner was not confirmed in the meeting, AI can only guess — and a wrong guess is passing the buck |
| Deciding what must not be sent outside | You | Discussions about pay, personnel, or unpublished projects must never go into notes that can be forwarded |

## 2. The five-step workflow: from recording to minutes you can send to the group

### Step 1: Five minutes before the meeting, fix the agenda and the recording

Half the quality of the notes is decided before the meeting starts. Do three small things beforehand:

1. **Write an agenda**: which decisions need to be made today, and roughly how long each one gets. A meeting with no agenda produces notes that read like a pile of running commentary.
2. **Confirm that you may record**: for an online meeting, use the meeting software's recording feature; for an in-person meeting, use your phone's recorder. Before you start recording, tell the people in the room: "I'll record this so I can write up the notes and send them to the group afterwards." That is politeness, and it is also the rule — people who do not know they are being recorded will cause trouble afterwards.
3. **Keep a notepad ready**: you do not need to write everything down, only three things — decisions made on the spot, names and numbers mentioned, and anything you think may be disputed later. Transcription misses tone and feeling; these three hand-written items are the anchors you check against.

### Step 2: During the meeting, record it — do not rely on handwriting

During the meeting, your job is to take part in the discussion, not to be the typist. There are three ways to record, depending on your meeting type:

- **Online meeting: use the meeting software's own feature first.** Take Tencent Meeting as an example: its auto-generated notes live under cloud recording as smart recording — you must turn on cloud recording first, then tick smart recording, and only after the meeting ends do you get a summary, notes, and action items. If the switch was never turned on, all you have afterwards is a video file. Feishu Meetings has Feishu Minutes, which transcribes as soon as you join. Before the meeting, check that the switch is on — it beats hunting for the recording afterwards.
- **In-person meeting: use your phone's recorder.** Put the phone in the middle of the table, not in your pocket. The built-in recorder on iPhone and Android both work; export the audio file after the meeting and transcribe it.
- **Nothing prepared, and handwriting is all you have**: then write down only the decisions and the action items, and fill in the rest immediately after the meeting — within half an hour of it ending you still remember the most; leave it until the next day and only half the details remain.

One reminder: the recording is the original evidence. Do not delete it in a hurry after the notes go out. If someone disputes a sentence in the notes, one minute of playback settles it.

### Step 3: Turn the recording into text

This is the first step AI takes over. There are two ways to do it:

- **The meeting software already transcribed it**: use its transcript directly. Tencent Meeting's smart recording and Feishu Minutes both produce a full transcript, and some can even split it by speaker.
- **You only have an audio file**: send the audio to an AI tool that supports speech-to-text, or transcribe it with a transcription tool first and then paste the transcript into a chat AI. Before uploading, check the length and file size — for a very long recording, split it by agenda item first; split transcription is faster and less likely to get confused.

Do not rush to organise the transcript once you have it. First give it a rough scan: is there a whole section of garbled text, or a place where two people talked over each other? Overlapping speech and heavy accents are where transcription goes wrong most often, and those are the parts to check carefully later.

### Step 4: Let AI organise it into notes

Paste the transcript into AI with a clear instruction. Do not just say "tidy up the meeting notes" — tell it what structure you want. The steadiest structure has four parts: **meeting info, discussion points, decisions, and action items**. For the exact wording, see the three templates in the next section — copy one directly.

Three techniques for this step:

1. **Do one thing at a time**: first ask AI for the summary and the decisions, check them, and only then ask it to pull out the action items. Ask for too much at once and AI will write an idea from the discussion as if it were a settled decision.
2. **Paste the agenda in with it**: put "Meeting agenda: 1... 2... 3..." before the transcript, and AI will organise by agenda item instead of mixing the discussion of two topics together.
3. **Ask it to flag what it is unsure about**: add one line to the prompt — "mark anything you cannot hear clearly or are unsure about; do not guess." A name or a number AI guessed is the most dangerous thing in a set of notes.

### Step 5: Check it, remove sensitive details, then send it to the group

An AI first draft must never be sent as it is. Run through this checklist before sending:

- [ ] **Are all the names right?** Same-sounding names are the easiest mistake — check them one by one.
- [ ] **Are the numbers and dates right?** Amounts, percentages, deadlines — match each one against the recording or your hand-written notes.
- [ ] **Does every action item have an owner and a deadline?** An action item with no owner is an item nobody will do; one with no deadline is one that will be put off forever.
- [ ] **Are decisions separated from discussion?** "We discussed it" is not the same as "we agreed on it." Writing something that was never decided into the decisions section guarantees an argument after the meeting.
- [ ] **Is sensitive content removed?** Pay, personnel, client confidences, and unpublished project details stay in the internal version and never go into the version sent to the group.
- [ ] **Is the tone right?** Notes sent to a client and notes sent internally are not written the same way — the external version drops the spoken wording and emotional language and keeps only facts and conclusions.

Send it only after checking. Once the workflow runs smoothly, an hour-long meeting usually takes about half an hour from the end of the meeting to the notes going out to the group.

## 3. Three prompt templates: copy and use directly

Pick one of the three templates below for what you need. Replace the parts in square brackets with your own details.

### Template 1: Standard notes (the most used)

```
Please organise the meeting transcript below into meeting notes.

Meeting info: [date, e.g. 25 November 2026; attendees: Zhang San, Li Si, Wang Wu; chair: Zhang San]
Meeting agenda: [1. Last quarter review; 2. Next quarter plan; 3. Roles and responsibilities]

Requirements:
1. Write it in four parts: "Meeting Info, Discussion Points, Decisions, Action Items".
2. Split the discussion points by agenda item; for each item, write the conclusion first, then the key reasons. Do not repeat everything everyone said.
3. Decisions may only include what was clearly agreed in the meeting. Anything not agreed stays in the discussion points; do not mix the two.
4. List the action items as a table with three columns: item, owner, deadline. If the owner was not stated clearly, write "to be confirmed" — do not guess.
5. Mark anything you cannot hear clearly or are unsure about as "(to be checked)" — do not make it up.
6. Keep the language concise, in reporting style, with no pleasantries.

Transcript:
[Paste the transcript here]
```

### Template 2: Action-item tracking (only for who has to do what)

```
Please extract all action items from the meeting transcript below.

Requirements:
1. List only things that clearly need doing. Ideas and suggestions raised in discussion do not count as action items.
2. Output one table: item, owner, deadline, and which part of the discussion it came from (one sentence summarising the original remark is enough).
3. If the owner or deadline was not stated clearly in the meeting, write "to be confirmed".
4. At the end, add one paragraph: which action items depend on each other — for example, "B cannot start until A is finished".

Transcript:
[Paste the transcript here]
```

This template fits weekly team meetings and project progress meetings. Paste the table into the group after the meeting and everyone can see at a glance who is responsible for what; at the next meeting, go through the table directly to check progress.

### Template 3: External notes (for a client or partner)

```
Please organise the meeting transcript below into meeting notes that can be sent to the client.

Meeting info: [date, both sides attending, meeting topic]

Requirements:
1. Write only facts and conclusions both sides confirmed. Do not write the internal discussion, or our own plans that are not yet settled.
2. Structure: one sentence of background, confirmed items (as a list), and next steps (item, responsible side, time).
3. Formal and restrained in tone, no spoken language, no emotional words.
4. For anything involving price, schedule, or who is responsible, do not reword the original meaning at all; mark anything uncertain as "(to be confirmed by both sides)".
5. Keep the whole thing under 500 words.

Transcript:
[Paste the transcript here]
```

One extra safety step for external notes: before sending, let a colleague who attended the meeting read it, to confirm no internal position has slipped out.

## 4. Three scenario playbooks: different meetings, different notes

### Scenario 1: Weekly team meeting — focus on action items, not a running commentary

A weekly meeting is the easiest to write as a running commentary: everything anyone said gets written down, and nobody wants to read it. The right way is three parts — "last week's action items checked off + this week's new action items + blockers" — with the discussion summed up in one sentence.

A small technique: use Template 2 for every weekly meeting and paste the action-item table into the group afterwards. At the next meeting, check the table first: which of last week's items are done, which are delayed, and why. After three months, the change in the team's execution is more visible than in any report.

### Scenario 2: Client meeting — focus on confirmation, leave no room for ambiguity

Notes from a client meeting are not a record — they are evidence. Send them to the other side within 24 hours of the meeting, with the date and topic clear in the title, writing only what both sides confirmed, and end with one line: "Please reply if anything here is wrong."

The most common problem is "thinking the other side agreed": in the meeting they said "we can consider it," and the notes write "both sides confirmed" — that is the seed of a dispute. Anything that was not clearly nodded to should be written as "to be confirmed by the other side." One more round of confirmation is better than one ambiguous sentence.

### Scenario 3: Cross-department project meeting — focus on responsibilities and dependencies

For a cross-department meeting, add one more section on top of the action-item table: "dependencies." Department A's delivery is the precondition for Department B to start; B's testing has to wait for C's data. Write the dependencies down clearly, and when the project slips you can see the bottleneck at a glance.

One more practice: after sending the notes to the group, sync the action items into the team's task tool (Feishu Tasks, DingTalk to-dos, TAPD — any of them), set the deadlines, and let it remind people automatically. Notes are only for recording; reminders need a tool, or sending them to the group is the same as throwing them into the sea.

## 5. The four easiest pitfalls

### Pitfall 1: The meeting was never recorded — you only find out after it ends

This is the most common failure. An online meeting without cloud recording turned on; an in-person meeting with a phone out of battery, or the record button never pressed. The fix is a pre-meeting checklist: one minute before the meeting, confirm the recording is on, and make it a habit. For an important meeting, add a second layer of insurance: start recording on your phone at the same time, so you have a backup copy.

### Pitfall 2: Sending the AI first draft straight to the group

AI will write an idea from the discussion as a decision, and will write "the manager said we could try it" as "it was decided to try it." Sending the first draft as it is means deciding on behalf of everyone. There is only one fix: the checklist in Step 5, with not one item skipped.

### Pitfall 3: Wrong names and numbers that nobody notices

Transcription hears "Li Lei" as "Li Lei" with a different character, and "15%" as "50%" — mistakes AI cannot catch itself. When checking, focus on three kinds of things: names, amounts and percentages, and dates. If a number is wrong, not one sentence in the notes can be trusted.

### Pitfall 4: Sensitive content travelling with the notes

An internal meeting discussed a pay adjustment, the notes went out to the large group unchanged, and the whole company knew by the next day. The fix is two versions: the full internal version goes only to the people who attended; the external version has the sensitive discussion removed before it is sent. Before sending, ask yourself one question: if this sentence were screenshotted and passed around, would it be a problem? If yes, delete it.

## Frequently asked questions

**Q: The meeting was not recorded, and all I have is a few lines of hand-written notes. Can AI still help?**

A: Yes, but use it differently. Paste the few lines of notes into AI and ask it to expand them into a structure and fill in the action-item format — not to invent details out of thin air. Write "to be confirmed" for anything missing, and ask the attendees to fill it in after the meeting. AI can only organise what you give it; the less you give, the more it invents.

**Q: AI's notes sound too formal, like an official document. What can I do?**

A: Add one line to the template about how you normally write, for example: "Write in the tone I normally use when updating progress in the group chat — no formal set phrases." Or, after the first draft, rewrite the three to five sentences that sound most awkward yourself, then ask AI to rewrite the whole thing in that tone. Two rounds and the tone will feel right.

**Q: The transcript has heavy dialect and accents, with many wrong characters. Is it still usable?**

A: It is usable, but the checking has to be more careful. First ask AI to organise one version using the template, then go through the recording to check the sections with the most errors. If a whole section cannot be heard clearly, write in the notes directly: "This part of the discussion was not recorded clearly; refer to the recording." That is better than inventing a section.

**Q: The meeting involves company secrets. Can I paste it into AI?**

A: First check the AI tool's privacy terms: whether chat history is used for training, and whether your company has a clear rule. The safe approach is to use only an internally deployed or enterprise version of an AI tool for confidential meetings. If you are not sure, paste only a redacted version — replace names with roles and specific numbers with "to be checked" — organise the structure, then fill the details back in yourself. Do not paste secrets into a public AI product.

**Q: Will my manager think I am cutting corners by using AI for meeting notes?**

A: No. A manager looks at whether the notes are accurate, whether the action items are clear, and whether they were sent promptly — not at whether you typed every word by hand. Write them this way — the facts are true, the numbers are checked, the action items have owners — and the notes are your work; the tool only saved you the typing and formatting time.

## Summary

Writing meeting notes with AI comes down to three sentences: **turn the recording on before the meeting, let AI handle only the transcription and the structure, and check the numbers and the owners yourself.** The workflow is five steps: set the agenda and the recording before the meeting, record it during the meeting, transcribe it afterwards, let AI organise it with a template, and check it and remove sensitive details before sending it to the group. Start by copying Template 1, and switch templates by scenario once it runs smoothly.

Try it once today: turn the recording on before your next meeting, copy Template 1 after it ends, and run it once — you can have a sendable version within half an hour. Compare that with how long handwriting used to take; the time you save is the answer to whether this method is worth it.

## Verification and update log

- Checked on: 2026-11-26
- Sources: this article does not involve specific product prices or version numbers. Tool names (Tencent Meeting, Feishu Minutes, Kimi, Doubao, ChatGPT, Claude) are public product names; the statement that Tencent Meeting's smart recording requires cloud recording to be turned on with the smart recording switch ticked follows a third-party account of Tencent Meeting's official documentation (article of 2026-11-22), and free-tier limits follow the official page — this article makes no commitment on them. Prices and free allowances follow each product's official site; nothing here is a commitment.
- Experience notes: "about half an hour from the end of an hour-long meeting to the notes going out" is an experience estimate and depends on recording quality and transcription accuracy; "splitting a transcript by agenda item is more accurate" is an experience judgement.
- Disclosure: this article has no commercial partnership and recommends no paid product.
- Privacy note: tell attendees before recording; for confidential meetings, handle the recording and the notes according to your company's rules, and do not paste sensitive content into a public AI product.

## Update log

- 2026-11-26: First published (English version; Chinese version published 2026-11-25).

## Related reading

- [How to Make a PPT with AI: From Outline to a Deck You Can Present](/en/posts/ai-ppt-workflow/)
- [How to Write a Weekly Report with AI: 5 Steps from a Diary to a Report You Can Submit](/en/posts/ai-weekly-report/)
- [AI Automation Office Guide 2026: Using ChatGPT for Excel, Word, Email, and Meeting Notes](/posts/ai-automation-office-2026/) (in Chinese)
- [ChatGPT Prompt Techniques](/posts/chatgpt-prompt-advanced-2026/) (in Chinese)
