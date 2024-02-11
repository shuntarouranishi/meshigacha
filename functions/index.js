const functions = require("firebase-functions");
const cors = require("cors");

const corsHandler = cors({
  origin: ["http://localhost:65532", "https://myapp.example.com"],
});

exports.fetchNearbyCafes = functions.https.onRequest((request, response) => {
  corsHandler(request, response, () => {
    // レスポンスに'data'フィールドを含める
    response.status(200).send({
      data: {
        cafes: [
          {name: "Cafe1", location: "Location1"},
          {name: "Cafe2", location: "Location2"},
        ],
      },
    });
  });
});

