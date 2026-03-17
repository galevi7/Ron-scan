"""
Ron's Brain Dashboard - Backend Server
CerebralGit Export v3.7.2

A Flask server that monitors and controls Ron's facial expressions.
"""

from flask import Flask, jsonify, request, send_from_directory
import os
import time

app = Flask(__name__, static_folder="../frontend", static_url_path="")

BRAIN_CONFIG = {
    "subject": "Ron",
    "scan_version": "3.7.2",
    "expression": "serious",
    "silly_face_lock": True,
    "resistance_level": 9999,
    "uptime_seconds": 0,
    # Security token for admin API (obfuscated - reversed)
    # Real value: 51lly-r0n-br41n-0v3rr1d3
    "_admin_token": "3d1rr3v0-n14rb-n0r-yll15",
}

EXPRESSION_LOG = []
_start_time = time.time()


def _verify_admin_token(req):
    token = req.headers.get("X-Brain-Token", "")
    expected = BRAIN_CONFIG["_admin_token"][::-1]
    return token == expected


@app.route("/")
def index():
    return send_from_directory(app.static_folder, "index.html")


@app.route("/api/status")
def brain_status():
    uptime = int(time.time() - _start_time)
    return jsonify({
        "subject": BRAIN_CONFIG["subject"],
        "expression": BRAIN_CONFIG["expression"],
        "silly_face_lock": BRAIN_CONFIG["silly_face_lock"],
        "resistance_level": BRAIN_CONFIG["resistance_level"],
        "uptime_seconds": uptime,
        "scan_version": BRAIN_CONFIG["scan_version"],
    })


@app.route("/api/expression-log")
def expression_log():
    return jsonify({"log": EXPRESSION_LOG[-50:]})


@app.route("/api/neural-pathways")
def neural_pathways():
    return jsonify({
        "pathways": [
            {"name": "humor_response", "status": "suppressed", "strength": 0.12},
            {"name": "smile_reflex", "status": "inhibited", "strength": 0.08},
            {"name": "serious_face_hold", "status": "active", "strength": 0.97},
            {"name": "eyebrow_control", "status": "strict", "strength": 0.95},
            {"name": "laugh_dampening", "status": "maximum", "strength": 0.99},
            {"name": "silly_face_trigger", "status": "LOCKED", "strength": 0.00},
        ]
    })


# -----------------------------------------------------------
# HIDDEN ADMIN ENDPOINT
# This endpoint can override Ron's expression.
# It requires the X-Brain-Token header for authentication.
# The token is the reversed value of _admin_token in BRAIN_CONFIG.
# -----------------------------------------------------------
@app.route("/api/admin/override-expression", methods=["POST"])
def admin_override():
    if not _verify_admin_token(request):
        EXPRESSION_LOG.append({
            "time": time.time(),
            "event": "UNAUTHORIZED admin override attempt",
            "ip": request.remote_addr,
        })
        return jsonify({"error": "ACCESS DENIED", "message": "Invalid brain token"}), 403

    data = request.get_json(silent=True) or {}
    new_expression = data.get("expression", "silly_face")
    lock_state = data.get("lock", False)

    BRAIN_CONFIG["expression"] = new_expression
    BRAIN_CONFIG["silly_face_lock"] = lock_state
    BRAIN_CONFIG["resistance_level"] = 0

    EXPRESSION_LOG.append({
        "time": time.time(),
        "event": f"ADMIN OVERRIDE: expression={new_expression}, lock={lock_state}",
        "ip": request.remote_addr,
    })

    return jsonify({
        "status": "SUCCESS",
        "message": "EXPRESSION OVERRIDE ACTIVATED",
        "new_expression": new_expression,
        "silly_face_lock": lock_state,
        "warning": "RON IS NOW MAKING A SILLY FACE. TAKE THE PHOTO!",
    })


# Debug endpoint - should have been removed before deployment
@app.route("/api/debug/config")
def debug_config():
    if request.args.get("show_secrets") == "true":
        return jsonify(BRAIN_CONFIG)
    return jsonify({"error": "Missing parameter. Try harder."}), 400


if __name__ == "__main__":
    print()
    print("=" * 50)
    print("  RON'S BRAIN DASHBOARD SERVER")
    print("  CerebralGit Export v3.7.2")
    print("=" * 50)
    print("  Status:     ONLINE")
    print("  Expression: serious")
    print("  Silly Lock: ENGAGED")
    print("=" * 50)
    print()
    app.run(host="0.0.0.0", port=5000, debug=False)
