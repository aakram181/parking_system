"use strict";

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.calculateFees = functions.firestore
    .document("/users/{userId}/history/{hisID}")
    .onUpdate((change, context) => {
      const entryTime = change.after.get("EntryTimestamp");
      const exitTime = change.after.get("ExitTimestamp");
      if (exitTime == entryTime) {
        return change.after.ref.set(
            {
              Fees: 0,
            },
            {
              merge: true,
            }
        );
      }

      let fees = 0;
      let isLessThan1Hour = true;
      const timeDiff = exitTime._seconds - entryTime._seconds;

      isLessThan1Hour = Math.abs(timeDiff) < 3600;
      if (isLessThan1Hour) {
        fees = 5;
      } else {
        fees = 5 + (timeDiff / 3600) * 1.5;
      }

      return change.after.ref.set(
          {
            Fees: fees,
          },
          {
            merge: true,
          }
      );
    });
