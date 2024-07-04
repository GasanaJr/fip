/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");
require("dotenv").config();

admin.initializeApp();

// Nodemailer
const transporter = nodemailer.createTransport({
  service: "hotmail",
  auth: {
    user: process.env.EMAIL,
    pass: process.env.PASSWORD,
  },
});

exports.sendEmailVerification = functions.https.onCall(
  async (data, context) => {
    const email = data.email;
    const verificationCode = Math.floor(100000 + Math.random() * 900000); // Generate OTP

    const mailOptions = {
      from: process.env.EMAIL,
      to: email,
      subject: "Your OTP verification code",
      text: `Your verification code is ${verificationCode}`,
    };

    await transporter.sendMail(mailOptions);

    // Store the code in the database or cache it with an expiration time
    await admin.firestore().collection("emailVerifications").doc(email).set({
      code: verificationCode,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true };
  }
);
