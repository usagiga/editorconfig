# editorconfig

My editorconfig.

## Installation

```sh
curl -fsSL https://editorconfig.usagiga.me/install.sh | bash
```

## Updating

### CI/CD

Installation script interpolates GitHub Actions workflows.
The workflow opens PR if needed.

So just you review / merge it.

### Manual

```sh
bash ./.editorconfig.d/scripts/install.sh
git add .editorconfig.d .editorconfig .github/workflows/editorconfig.yml .github/workflows/update-editorconfig.yml
git commit -m 'Bump version .editorconfig [skip ci]'
```

## LICENSE

MIT
