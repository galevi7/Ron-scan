"""
Ron's Brain - Neural Weakness Model Trainer
CerebralGit Export v3.7.2

Trains a classifier on friends' behavioral data to predict
silly face triggers based on personality metrics.
"""

import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import cross_val_score
from sklearn.preprocessing import LabelEncoder
import joblib
import os

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


def load_and_prepare_data():
    print("[*] Loading friends behavioral data...")
    df = pd.read_csv(DATA_PATH)
    print(f"[*] Loaded {len(df)} records")
    print()

    print("=" * 60)
    print("  SUBJECT DATABASE")
    print("=" * 60)
    for _, row in df.iterrows():
        trigger = row["silly_face_trigger"]
        marker = " <<< TARGET" if row["name"] == "Ron" else ""
        print(f"  {row['name']:>8s} | seriousness={row['seriousness_score']:.1f} "
              f"| trigger={trigger}{marker}")
    print("=" * 60)
    print()

    train_df = df[df["silly_face_trigger"] != "???"].copy()
    ron_df = df[df["name"] == "Ron"].copy()

    return train_df, ron_df


def train_model(train_df):
    print("[*] Training weakness prediction model...")
    print()

    X = train_df[FEATURE_COLS]
    le = LabelEncoder()
    y = le.fit_transform(train_df["silly_face_trigger"])

    model = RandomForestClassifier(
        n_estimators=100,
        max_depth=5,
        random_state=42,
    )

    scores = cross_val_score(model, X, y, cv=5, scoring="accuracy")
    print(f"[*] Cross-validation accuracy: {scores.mean():.2%} (+/- {scores.std():.2%})")
    print()

    model.fit(X, y)

    print("=" * 60)
    print("  FEATURE IMPORTANCE ANALYSIS")
    print("=" * 60)
    importances = sorted(
        zip(FEATURE_COLS, model.feature_importances_),
        key=lambda x: x[1],
        reverse=True,
    )
    for feat, imp in importances:
        bar = "#" * int(imp * 40)
        print(f"  {feat:>25s} | {imp:.3f} | {bar}")
    print("=" * 60)
    print()

    print(f"[*] Key insight: '{importances[0][0]}' is the strongest predictor")
    print(f"    of silly face triggers. Ron's value for this feature is")
    print(f"    EXTREMELY high, which narrows down his trigger category.")
    print()

    joblib.dump(model, MODEL_PATH)
    joblib.dump(le, ENCODER_PATH)
    print(f"[+] Model saved to: {MODEL_PATH}")
    print(f"[+] Encoder saved to: {ENCODER_PATH}")

    return model, le


def main():
    print()
    print("  ====================================")
    print("   RON'S BRAIN - WEAKNESS MODEL")
    print("   CerebralGit Neural Analysis")
    print("  ====================================")
    print()

    train_df, _ = load_and_prepare_data()
    train_model(train_df)

    print()
    print("[*] Training complete. Run predict.py to analyze Ron's weakness.")
    print()


if __name__ == "__main__":
    main()
