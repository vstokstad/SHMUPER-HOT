using System;

using Managers;
using Shapes;
using UI.TouchUI;
using UnityEngine;

namespace Actors.Player {
    [RequireComponent(typeof(Joystick))]
    public class PlayerInput : MonoBehaviour {
  
  
        [SerializeField] public GameObject gamePad;
        internal float gamePadRadius;
        [SerializeField] public Rectangle rectangleButton;
        [SerializeField] public Disc discButton;

        public static Action boost;
        public static Action shoot;
        public static Action shield;
        [SerializeField] private Joystick joystick;


        private void Awake(){
       

            if (GameManager.OnMobile) {
                Input.multiTouchEnabled = true;
                gamePad.SetActive(true);
                gamePadRadius = gamePad.GetComponent<Disc>().Radius;
            }
            else {
                Destroy(gamePad);
            }
        }

       

        private void Update(){
            joystick.TouchMoveControl();
            if (Input.GetButton("Fire1")) shoot();
            if (Input.GetButton("Boost")) boost();
            if (Input.GetButtonDown("Shield")) shield();
            
        }
    }
}