# Brain Dashboard - Ron's Expression Web Interface

> **Agent 3 - Your Mission: Hack into Ron's Brain Dashboard and find the
> hidden admin panel that controls his facial expressions.**

## Background

Ron's brain runs a web dashboard (Flask + HTML/CSS) that monitors and
controls his facial expressions. The frontend shows his current state, but
there's a hidden admin API that can override his expression. The developers
left some... interesting security holes.

## Prerequisites

- Python 3.8+
- pip

## Step 1: Install Dependencies

```bash
pip install -r requirements.txt
```

## Step 2: Run the Server

```bash
cd backend
python server.py
```

The dashboard will be available at `http://localhost:5000`

## Step 3: Explore the Dashboard

Open the browser. You'll see Ron's brain dashboard showing his current
expression status. Everything looks locked down... or does it?

## Investigation Guide

1. **View the page source** - Right-click -> View Source. Developers
   sometimes leave comments in HTML...

2. **Check the API** - Try hitting `/api/status` in your browser. What
   other endpoints might exist?

3. **Read the source code** - The backend code is in `backend/server.py`.
   Look for hidden routes, hardcoded credentials, and debug features.

4. **Use curl or Postman** to test any hidden endpoints you find.

## Hints (read only if stuck)

<details>
<summary>Hint 1 - The HTML comment</summary>
View the page source. There's a commented-out section that references an
admin panel and an API endpoint that wasn't meant to be discovered.
</details>

<details>
<summary>Hint 2 - The secret endpoint</summary>
There's an endpoint at `/api/admin/override-expression`. It requires a
special header to authenticate.
</details>

<details>
<summary>Hint 3 - Finding the token</summary>
Look in `server.py` for the configuration dictionary. The admin token is
there, but it's been "obfuscated" using a simple technique. Look for
something reversed or encoded.
</details>

<details>
<summary>Hint 4 - The full exploit</summary>

```bash
curl -X POST http://localhost:5000/api/admin/override-expression \
  -H "Content-Type: application/json" \
  -H "X-Brain-Token: 51lly-r0n-br41n-0v3rr1d3" \
  -d '{"expression": "silly_face", "lock": false}'
```

The token is in the source code, reversed as `3d1rr3v0-n14rb-n0r-yll15`.
</details>

## What You're Looking For

1. The HTML comment breadcrumb in the frontend
2. The hidden admin API endpoint
3. The obfuscated authentication token
4. Successfully calling the override endpoint to unlock Ron's silly face

Film yourself discovering the clues one by one. Start at the browser,
dig into source, and finish with the triumphant curl command.

---

*"His frontend looks serious, but his backend is full of jokes." - CerebralGit Report*
