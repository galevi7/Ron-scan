# Neural Model - Ron's Weakness Predictor

> **Agent 4 - Your Mission: Use the trained ML model on our crew's data
> to predict Ron's weakness - the trigger that forces a silly face.**

## Background

CerebralGit extracted a predictive model from Ron's brain. We've also
collected behavioral data from all of us (his friends) - our seriousness
levels, ticklishness, surprise vulnerability, and known silly face triggers.

The theory: by training a model on people similar to Ron and feeding in
Ron's parameters, we can **predict** what will trigger his silly face.

## Prerequisites

- Python 3.8+
- pip

## Step 1: Install Dependencies

```bash
pip install -r requirements.txt
```

## Step 2: Explore the Data

```bash
cat data/friends_data.csv
```

Look at the training data. Notice the columns - each person has measurable
attributes and a known `silly_face_trigger` category. Ron's entry has a
trigger value of `???` - that's what we're predicting.

## Step 3: Train the Model

```bash
python train_model.py
```

This trains a classifier on everyone's data (except Ron) and saves the
model. Pay attention to the output - it shows feature importances and
model accuracy.

## Step 4: Predict Ron's Weakness

```bash
python predict.py
```

This loads Ron's data and the trained model, then predicts his most likely
silly face trigger with confidence scores.

## Investigation Guide

1. **Look at the data first** - What patterns do you see? Who is Ron most
   similar to?
2. **Check feature importances** - Which attributes matter most for
   predicting silly face triggers?
3. **Examine the prediction probabilities** - The model outputs confidence
   for each possible trigger category. Which one wins?
4. **Look at the `CLASSIFIED` output** - The prediction script has a
   special section that only prints when confidence exceeds a threshold.

## Hints (read only if stuck)

<details>
<summary>Hint 1 - The data patterns</summary>
Look at people with high `seriousness_score` and low `ticklishness`. Ron
shares traits with a specific subset. Their triggers cluster around one
category.
</details>

<details>
<summary>Hint 2 - Feature importance</summary>
The model weights `surprise_vulnerability` very heavily. Ron's surprise
vulnerability score is... interesting. Cross-reference with others who
have similar scores.
</details>

<details>
<summary>Hint 3 - The hidden output</summary>
The prediction script checks if confidence > 0.7. If so, it prints a
"CLASSIFIED INTELLIGENCE REPORT" with specific tactical recommendations.
Run it and see.
</details>

<details>
<summary>Hint 4 - The answer</summary>
The model predicts with high confidence that Ron's trigger is
"unexpected_compliment_plus_silly_sound". The tactical recommendation:
someone needs to sincerely compliment Ron and immediately follow with
a ridiculous sound effect. His brain can't process the context switch.
</details>

## What You're Looking For

1. Explore and explain the training data on camera
2. Train the model and show the feature importances
3. Run the prediction and reveal Ron's predicted weakness
4. Read aloud the CLASSIFIED report with tactical recommendations

Film the whole process - data exploration through the big reveal.

---

*"His model is well-trained, but his friends have better data." - CerebralGit Report*
