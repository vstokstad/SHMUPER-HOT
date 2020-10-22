using System;
using Actors.Weapons;
using Managers;
using Shapes;
using UI;
using UnityEngine;
using UnityEngine.UIElements;

namespace Actors.Player {
    [RequireComponent(typeof(Joystick))]
    public class PlayerInput : MonoBehaviour {
        internal PlayerMovement _movement;
        private ShieldControl _shieldControl;
        private WeaponController _weaponController;
        public GameObject gamePad;
        internal float _gamePadRadius;
        public Button rectangleButton;
        public Button discButton;

        public static Action Boost = delegate{ };
        public static Action Shoot = delegate{ };
        public static Action Shield = delegate{ };
        private Joystick _joystick;


        private void Awake(){
            _movement = GetComponent<PlayerMovement>();
            _joystick = GetComponent<Joystick>();
        
            if (GameManager.OnMobile) {
                Input.multiTouchEnabled = true;
                gamePad.SetActive(true);
                _gamePadRadius = gamePad.GetComponent<Disc>().Radius;
            }
            else {
                Destroy(gamePad);
            }
        }


        private void Update(){
            _joystick.TouchMoveControl();
            //  _movement.upDownInput = Input.GetAxis("Vertical");
            //  _movement.sidewaysInput = Input.GetAxis("Horizontal");
            //  _shieldControl.shieldInput = Input.GetButtonDown("Shield");
            //  _movement.boostInput = Input.GetButton("Boost");
            //  _weaponController.fireInput = Input.GetButton("Fire1");
            //  _weaponController.nextWeaponInput = Input.GetButtonDown("Weapon Cycle");
        }
    }
}