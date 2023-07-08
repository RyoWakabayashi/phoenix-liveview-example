# LiveViewExample

Phoenix LiveView Example

## Requirements

[asdf]

## Start server

Install dependencies

```bash
mix setup
```

Start server

```bash
mix phx.server
```

## Setup for editing

Install asdf plugins

```bash
awk '{system("asdf plugin-add " $1)}' .tool-versions
```

Install languages

```bash
asdf install
```

Install dependencies

```bash
npm install && pip install --requirement requirements.txt
```

Setup pre-commit

```bash
pre-commit install
```

[asdf]: https://github.com/asdf-vm/asdf
