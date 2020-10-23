using System;
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
        
    }
}