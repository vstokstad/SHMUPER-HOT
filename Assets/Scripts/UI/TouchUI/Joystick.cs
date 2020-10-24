using System;
using Actors.Player;
using Managers;
using Shapes;
using UnityEngine;
using UnityEngine.UI;

namespace UI.TouchUI {
    public class Joystick : MonoBehaviour {
        private GameObject _gamePad;
        [SerializeField] private PlayerMovement playerMovement;
        public Button upButton;
        public Button downButton;
        public Button leftButton;
        public Button rightButton;
     

        private void Start(){
            _gamePad = this.gameObject;
            _gamePad.SetActive(true);
            upButton.onClick.AddListener(PlayerInput.moveUp + PlayerInput.move);
            downButton.onClick.AddListener(PlayerInput.moveDown + PlayerInput.move);
            leftButton.onClick.AddListener(PlayerInput.moveLeft + PlayerInput.move);
            rightButton.onClick.AddListener(PlayerInput.moveRight + PlayerInput.move);
        }

        private void OnEnable(){
            PlayerInput.moveUp += MoveUp;
            PlayerInput.moveDown += MoveDown;
            PlayerInput.moveLeft += MoveLeft;
            PlayerInput.moveRight += MoveRight;
        }

        private void MoveUp(){
            TouchMoveControl(Vector2.up);
        }

        private void MoveDown(){
            TouchMoveControl(Vector2.down);
        }

        private void MoveLeft(){
            TouchMoveControl(Vector2.left);
        }

        private void MoveRight(){
            TouchMoveControl(Vector2.right);
        }

        private Vector2 WorldToGamepad(Vector2 worldPt){
            Vector2 objPos = _gamePad.transform.position;
            Vector2 right = _gamePad.transform.right;
            Vector2 up = _gamePad.transform.up;
            Vector2 pointOffset = (worldPt - objPos);
            float x = Vector2.Dot(pointOffset, right);
            float y = Vector2.Dot(pointOffset, up);
            return new Vector2(x, y);
        }
        private void TouchMoveControl(Vector2 direction){
            playerMovement.TouchInput(direction);
        }

        private void OnDisable(){
            upButton.onClick.RemoveAllListeners();
            downButton.onClick.RemoveAllListeners();
            leftButton.onClick.RemoveAllListeners();
            rightButton.onClick.RemoveAllListeners();
        }
    }
    
}