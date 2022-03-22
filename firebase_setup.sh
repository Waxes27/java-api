#!/bin/bash
curl -sL https://firebase.tools | bash
npm install -g firebase-tools
firebase login
firebase projects:list