# Osaka Travel Journal — Public + Private Admin Edition

This package contains a static website plus a Supabase-powered private editor.
It is designed for GitHub Pages hosting and Supabase Auth + Postgres.

## What works after setup
- Public visitors can read the itinerary.
- Only the designated Supabase admin UUID can save changes.
- Admin login uses Supabase email/password authentication.
- Edits are saved in the Supabase database and appear to public visitors after refresh.
- Responsive layout and print-to-PDF.

## 1. Create Supabase project
1. Create a project at https://supabase.com/dashboard
2. In Authentication → Users, create an admin user with your email and a strong password.
3. Copy the admin user's UUID.
4. Open SQL Editor and run `supabase_schema.sql`, replacing `ADMIN_USER_UUID` with the copied UUID.
5. In Project Settings → API, copy the Project URL and anon/public key.

Do not use or publish the `service_role` key in this website.

## 2. Configure the website
Open `index.html` in a text editor and find:
- `YOUR_SUPABASE_PROJECT_URL`
- `YOUR_SUPABASE_ANON_PUBLIC_KEY`

Replace them with the Project URL and anon/public key from your Supabase project.
The anon/public key is intended for browser use; database permissions are enforced by RLS.
Never put your service_role key in `index.html`.

## 3. Publish with GitHub Pages
1. Create a GitHub repository, e.g. `osaka-travel-journal`.
2. Upload `index.html` to the repository root.
3. Open repository Settings → Pages.
4. Under Build and deployment, choose Deploy from a branch, select `main` and `/ (root)`, then Save.
5. Wait for the deployment and open the published URL shown in Settings → Pages.

GitHub Pages sites are public. Do not put passwords, private notes, or secret keys in the repository.

## 4. Use the site
- Public view: share the GitHub Pages URL.
- Admin: open the same URL, choose「管理員登入」, enter the Supabase admin email/password.
- Choose「開始編輯」, edit the itinerary text, then choose「雲端儲存」.
- Sign out when finished.

## Notes / limitations
- The initial itinerary is included in the HTML. The first successful admin save creates the cloud version.
- The current editor edits existing itinerary text fields. Adding/removing/reordering itinerary stops and uploading photos are not yet included in this starter edition.
- Checklist checkmarks are currently browser-local, not shared cloud state.
- Supabase and GitHub accounts must be created/authorized by the site owner. This package cannot publish to your accounts without your explicit account connection and setup.
