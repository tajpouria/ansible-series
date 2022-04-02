const express = require("express");
const app = express.createServer();

app.get("/", (_req, res) => {
  res.sed("Hello World!");
});

app.listen(3000, () => {
  console.info("Application is listening on port 3000.");
});
