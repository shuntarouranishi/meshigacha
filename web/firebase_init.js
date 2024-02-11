// Import the functions you need from the SDKs you need
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-analytics.js";

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyCHuWAPNt2XP2GW5LIf5d-72KG7Pczrw9U",  // Replace with your API key
  authDomain: "torima-4a05c.firebaseapp.com",  // Replace with your Auth Domain
  projectId: "torima-4a05c",  // Replace with your Project ID
  storageBucket: "torima-4a05c.appspot.com",  // Replace with your Storage Bucket
  messagingSenderId: "817720033710",  // Replace with your Messaging Sender ID
  appId: "1:817720033710:web:0245abc748865d1be4883f",  // Replace with your App ID
  measurementId: "G-N1YFG04D0E"  // Replace with your Measurement ID
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
