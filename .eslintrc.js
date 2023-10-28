/*eslint no-undef: 0*/

module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: [
    "eslint:recommended",
    "prettier",
  ],
  parserOptions: {
    ecmaVersion: "latest",
    sourceType: "module",
  },
  globals: {
    window: true,
    fetch: true,
    FileReader: true,
    Event: true,
    FormData: true,
  },
  root: true,
  rules: {
    "no-unused-vars": [
      "error",
      {
        args: "all",
        argsIgnorePattern: "^_",
      },
    ],
  },
};
