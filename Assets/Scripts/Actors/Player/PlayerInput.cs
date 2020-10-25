using UnityEngine;
using UnityEngine.Events;

namespace Actors.Player {
    public class PlayerInput : MonoBehaviour {
        public static UnityAction boost = delegate{ };
        public static UnityAction shoot = delegate{ };
        public static UnityAction shield = delegate{ };
        public static UnityAction move = delegate{ };
        public static UnityAction moveUp = delegate{ };
        public static UnityAction moveDown = delegate{ };
        public static UnityAction moveLeft = delegate{ };
        public static UnityAction moveRight = delegate{ };
        public static UnityAction nextWeapon = delegate{  };

       public void BatchUpdate(){
           if (!Input.anyKeyDown) return;
           move();
           if (Input.GetKey(KeyCode.W)){ moveUp();}
           if (Input.GetKey(KeyCode.S)) moveDown();
           if (Input.GetKey(KeyCode.A)) moveLeft();
           if (Input.GetKey(KeyCode.D)) moveRight();
           if (Input.GetKeyDown(KeyCode.Space)) shoot();
           if (Input.GetKeyDown(KeyCode.LeftShift)) boost();
           if (Input.GetKeyDown(KeyCode.F)) shield();
           if (Input.GetKeyDown(KeyCode.Q)) nextWeapon();
       }
    }
}