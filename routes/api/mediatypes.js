const express = require("express");
const router = express.Router();
const mediatypes = require("../../Mediatypes");

router.get("/", (req, res) => res.json(mediatypes));

module.exports = router;
