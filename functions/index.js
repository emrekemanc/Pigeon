
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");


initializeApp();

exports.sendNewMessageNotification = onDocumentCreated("messages/{messageId}", async (event) => {
  const message = event.data?.data();
  if (!message) return;

  const receiverID = message.receiver_id;
  const senderID = message.sender_id;

  try {
    const db = getFirestore();
    const userSnap = await db.collection("users").doc(receiverID).get();
    const user = userSnap.data();

    if (!user?.fcm_token) {
      console.log("FCM token bulunamadı.");
      return;
    }

    const payload = {
      notification: {
        title: "Yeni Mesaj",
        body: `${message.text}`
      },
      token: user.fcm_token
    };

    await getMessaging().send(payload);
    console.log("Bildirim gönderildi:", payload.notification.body);

  } catch (err) {
    console.error("Bildirim gönderme hatası:", err);
  }
});

exports.onNewChatCreated = onDocumentCreated("chats/{chatId}", async (event) => {
  const chat = event.data?.data();
  if (!chat) return;

  const chatId = event.params.chatId;
  const user1ID = chat.user1_id;
  const user2ID = chat.user2_id;

  const db = getFirestore();

  try {
    await Promise.all([user1ID, user2ID].map(async (uid) => {
      const userRef = db.collection("users").doc(uid);
      await userRef.update({
        chat_ids: admin.firestore.FieldValue.arrayUnion(chatId)
      });
    }));

    console.log(`Chat ID '${chatId}' her iki kullanıcıya eklendi.`);

  } catch (error) {
    console.error("Kullanıcılara chat ID eklenirken hata:", error);
  }
});