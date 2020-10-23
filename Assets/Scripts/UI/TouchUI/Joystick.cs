using System;
using Actors.Player;
using Managers;
using Shapes;
using UnityEngine;
using UnityEngine.UI;

namespace UI.TouchUI {
    public class Joystick : MonoBehaviour {
        private float _gamePadRadius;
        private GameObject _gamePad;
        [Tooltip("Up, Down, Left, Right")] public Button[] joystickButtons = new Button[4];
        [SerializeField] private PlayerMovement playerMovement;

        private Vector2 WorldToGamepad(Vector2 worldPt){
            Vector2 objPos = _gamePad.transform.position;
            Vector2 right = _gamePad.transform.right;
            Vector2 up = _gamePad.transform.up;
            Vector2 pointOffset = (worldPt - objPos);
            float x = Vector2.Dot(pointOffset, right);
            float y = Vector2.Dot(pointOffset, up);
            return new Vector2(x, y);
        }

        private void Start(){
            _gamePad = this.gameObject;
            _gamePad.SetActive(true);
            _gamePadRadius = _gamePad.GetComponent<Disc>().Radius;
            joystickButtons[0].onClick.AddListener(Move);
            joystickButtons[1].onClick.AddListener(Move);
            joystickButtons[2].onClick.AddListener(Move);
            joystickButtons[3].onClick.AddListener(Move);
            PlayerInput.move += TouchMoveControl;
        }

        private void Update(){ }

        private void Move(){
            PlayerInput.move();
        }

        private void TouchMoveControl(){
//TODO remove print
            print("TouchMoveControl");
            
            Vector2 mousePos = Input.mousePosition;
            
            Vector2 gamepadTouch = WorldToGamepad(mousePos).normalized;
            playerMovement.TouchInput(gamepadTouch);
        }

        private void OnDisable(){
            foreach (Button button in joystickButtons) {
                button.onClick.RemoveAllListeners();
            }
        }
    }
}