# Feature Folder Guide (Beginner)

This project follows the **auth** feature as the template.
Every feature should look like this so anyone can find code quickly.

## Big picture (top → bottom)

```
UI (pages / widgets / bloc)
        ↓
Use case (domain)     ← "one job" of the app
        ↓
Repository contract (domain)
        ↓
Repository impl (data)
        ↓
Remote data source (core/datasources)  ← real API / Dio
```

## Folder template (copy this)

Example feature name: `all_patients`  
Use-case name (same for simple features): `all_patients`

```
lib/feature/<area>/<feature_name>/
  data/
    <use_case>_data/
      models/              # JSON → Dart (UserModel style)
      repositories/        # talks to data source, returns Entity
  domain/
    <use_case>_domain/
      entities/            # pure business objects (no Dio/JSON)
      repositories/        # abstract contract only
      usecases/            # one class = one job
  presentation/
    bloc/
      <use_case>_bloc/     # event + state + bloc
    pages/
      <screen_name>/       # one folder per screen
        <screen_name>_page.dart
    widgets/
      form/ | other/ | sections/   # UI pieces only
```

### Auth (reference — already done)

```
feature/auth/
  data/login_data/...
  data/forget_password_data/...
  data/change_password_data/...
  domain/login_domain/...
  domain/forget_password_domain/...
  domain/change_password_domain/...
  presentation/bloc/login_bloc/...
  presentation/bloc/forget_password_bloc/...
  presentation/bloc/change_password_bloc/...
  presentation/pages/login|forgot_password|change_password/
  presentation/widgets/
```

Auth has **3 use cases** → 3 folders under data / domain / bloc.

### Datasources (API layer)

Live in **core**, not inside the feature:

```
lib/core/datasources/<feature_name>/
  <feature>_remote_data_source.dart       # abstract
  <feature>_remote_data_source_impl.dart  # Dio calls
```

Why? So all network code stays in one place. Feature `data` repositories call these.

### DI (wiring)

```
lib/core/di/<feature>_module.dart   # register data source → repo → use case → bloc
lib/core/di/di_setup.dart           # add module to the list
```

## Rules for beginners

1. **Do not invent a new layout** — copy auth or an existing feature.
2. **UI-only first is OK** — stub domain+data+bloc folders can exist before API work.
3. **Do not register stubs in DI** until the API is wired (keeps the app running with sample UI).
4. **UI ↔ Bloc (locked):** UI = events out + states in only. Never call UseCase/Repo from a page/widget.
5. **One widget = one file**. Screens only in `pages/<name>/`.
6. **Comments in English** explaining *why* a file exists.
7. When API is ready: fill model → data source → repository impl → use case → bloc → page → register DI module.

## When to create a new `*_data` / `*_domain` folder

- New screen with its own API → new use-case folders (like auth login vs change password).
- Same screen, same API → keep one use-case folder.
