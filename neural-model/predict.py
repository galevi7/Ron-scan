"""
Ron's Brain - Weakness Prediction Engine
CerebralGit Export v3.7.2

Loads the trained model and predicts Ron's silly face trigger
based on his personality metrics.
"""

import pandas as pd
import joblib
import os
import time

DATA_PATH = os.path.join(os.path.dirname(__file__), "data", "friends_data.csv")
MODEL_PATH = os.path.join(os.path.dirname(__file__), "weakness_model.pkl")
ENCODER_PATH = os.path.join(os.path.dirname(__file__), "label_encoder.pkl")

FEATURE_COLS = [
    "seriousness_score",
    "ticklishness",
    "surprise_vulnerability",
    "compliment_confusion",
    "humor_resistance",
    "dance_embarrassment",
    "dad_joke_weakness",
]


def dramatic_print(text, delay=0.03):
    for char in text:
        print(char, end="", flush=True)
        time.sleep(delay)
    print()


def predict_rons_weakness():
    print()
    print("  ====================================")
    print("   CLASSIFIED INTELLIGENCE ANALYSIS")
    print("   Subject: Ron")
    print("   Operation: Silly Face")
    print("  ====================================")
    print()

    if not os.path.exists(MODEL_PATH):
        print("[ERROR] Model not found. Run train_model.py first.")
        return

    print("[*] Loading trained model...")
    model = joblib.load(MODEL_PATH)
    le = joblib.load(ENCODER_PATH)

    print("[*] Loading Ron's behavioral data...")
    df = pd.read_csv(DATA_PATH)
    ron = df[df["name"] == "Ron"]

    if ron.empty:
        print("[ERROR] Ron's data not found in database.")
        return

    X_ron = ron[FEATURE_COLS]

    print("[*] Analyzing Ron's neural patterns...")
    print()
    time.sleep(1)

    print("  RON'S PROFILE:")
    print("  " + "-" * 40)
    for col in FEATURE_COLS:
        val = ron[col].values[0]
        bar = "*" * int(val)
        print(f"  {col:>25s}: {val:.1f} {bar}")
    print("  " + "-" * 40)
    print()

    time.sleep(1)

    probabilities = model.predict_proba(X_ron)[0]
    classes = le.classes_

    print("[*] Running prediction engine...")
    print()
    time.sleep(0.5)

    print("  TRIGGER PROBABILITY ANALYSIS:")
    print("  " + "-" * 50)
    ranked = sorted(zip(classes, probabilities), key=lambda x: x[1], reverse=True)
    for trigger, prob in ranked:
        bar = "#" * int(prob * 40)
        marker = " <<<" if prob == max(probabilities) else ""
        print(f"  {trigger:>42s}: {prob:.1%} {bar}{marker}")
    print("  " + "-" * 50)
    print()

    top_trigger = ranked[0][0]
    top_confidence = ranked[0][1]

    time.sleep(1)

    if top_confidence > 0.4:
        print()
        print("  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("  !!                                           !!")
        print("  !!   C L A S S I F I E D   R E P O R T       !!")
        print("  !!                                           !!")
        print("  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print()
        time.sleep(0.5)

        dramatic_print(f"  PREDICTED TRIGGER: {top_trigger}")
        dramatic_print(f"  CONFIDENCE: {top_confidence:.1%}")
        print()
        dramatic_print("  TACTICAL RECOMMENDATION:")
        print()

        if "compliment" in top_trigger:
            dramatic_print("  1. Approach Ron casually")
            dramatic_print("  2. Deliver a SINCERE, specific compliment")
            dramatic_print("     (e.g., 'Ron, you have genuinely great hair')")
            dramatic_print("  3. IMMEDIATELY follow with a ridiculous sound")
            dramatic_print("     effect ('BAZINGA!' / armpit fart / kazoo)")
            dramatic_print("  4. Ron's brain cannot process the context switch")
            dramatic_print("     between sincerity and absurdity")
            dramatic_print("  5. His serious_face module will crash")
            dramatic_print("  6. TAKE THE PHOTO IMMEDIATELY")
        elif "dad_joke" in top_trigger:
            dramatic_print("  1. Set up a seemingly serious conversation")
            dramatic_print("  2. Hit him with the worst dad joke possible")
            dramatic_print("  3. Maintain eye contact. Do not blink.")
        elif "funny_sounds" in top_trigger:
            dramatic_print("  1. Wait for a quiet moment")
            dramatic_print("  2. Make the most absurd sound you can")
            dramatic_print("  3. Maintain absolute seriousness while doing it")
        else:
            dramatic_print("  1. Just... do literally anything silly")
            dramatic_print("  2. It doesn't take much")

        print()
        dramatic_print("  OPERATION SILLY FACE: APPROVED")
        dramatic_print("  Good luck, agents. Make us proud.")
        print()
    else:
        print("[*] Confidence too low for definitive prediction.")
        print("[*] Recommend gathering more data on the subject.")


if __name__ == "__main__":
    predict_rons_weakness()
