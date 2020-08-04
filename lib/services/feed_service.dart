import 'package:cloud_firestore/cloud_firestore.dart';

class FeedService {
  static final db = Firestore.instance;

  // Ação a ser realizada quando o usuário clica no botão de curtir.
  // Roda uma Transaction no Firestore para operar múltiplas transações simultâneas de forma segura.
  // Caso o usuário já tenha curtido o post, remove o usuário da lista de curtidas (exclui o like)
  // Caso contrário, adiciona o usuário na lista de curtidas (dá um like)
  static Future<void> likeAction(String uid, String postId) async {
    try {
      await db.runTransaction((Transaction tx) async {
        DocumentSnapshot snapshot =
            await db.collection("posts").document(postId).get();
        List likes = List.from(snapshot.data['usersWhoLiked']);
        if (likes.contains(uid)) {
          await tx.update(snapshot.reference, <String, dynamic>{
            'usersWhoLiked': FieldValue.arrayRemove([uid]),
          });
        } else {
          await tx.update(snapshot.reference, <String, dynamic>{
            'usersWhoLiked': FieldValue.arrayUnion([uid]),
          });
        }
      });
    } catch (e) {
      print('An error ocurred while liking post. $e');
      throw e;
    }
  }

  static Future<int> getNumberOfLikes(String postId) async {
    DocumentSnapshot snapshot =
        await db.collection('posts').document(postId).get();
    return List.from(snapshot.data['usersWhoLiked']).length;
  }
}
