using System;
using Actors.Weapons;
using Managers;
using Shapes;
using UI;
using UI.TouchUI;
using UnityEngine;
using UnityEngine.UIElements;

namespace Actors.Player {
    [RequireComponent(typeof(Joystick))]
    public class PlayerInput : MonoBehaviour {
        [SerializeField] internal PlayerMovement movement;
        [SerializeField] public ShieldControl _shieldControl;
        [SerializeField] public WeaponController _weaponController;
        [SerializeField] public GameObject gamePad;
        internal float gamePadRadius;
        [SerializeField] public Rectangle rectangleButton;
        [SerializeField] public Disc discButton;

        public static Action boost;
        public static Action shoot;
        public static Action shield;
        [SerializeField] Joystick _joystick;


        private void Awake(){
            movement = GetComponent<PlayerMovement>();

            if (GameManager.OnMobile) {
                Input.multiTouchEnabled = true;
                gamePad.SetActive(true);
                gamePadRadius = gamePad.GetComponent<Disc>().Radius;
            }
            else {
                Destroy(gamePad);
            }
        }

        private void OnEnable(){
          
        }

        private void Update(){
            _joystick.TouchMoveControl();
            if (Input.GetButton("Fire1")) shoot();
            if (Input.GetButton("Boost")) boost();
            if (Input.GetButtonDown("Shield")) shield();
              movement.upDownInput = Input.GetAxis("Vertical");
              movement.sidewaysInput = Input.GetAxis("Horizontal");
              _shieldControl.shieldInput = Input.GetButtonDown("Shield");
            //  movement.boostInput = Input.GetButton("Boost");
            //  _weaponController.fireInput = Input.GetButton("Fire1");
            //  _weaponController.nextWeaponInput = Input.GetButtonDown("Weapon Cycle");
        }
    }
}