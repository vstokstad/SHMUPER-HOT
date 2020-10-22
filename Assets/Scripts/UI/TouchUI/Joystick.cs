using Actors.Player;
using Managers;
using UnityEngine;

namespace UI.TouchUI {
    public class Joystick : MonoBehaviour {
        [SerializeField] private PlayerInput _playerInput;
        

        private Vector2 WorldToGamepad(Vector2 worlPt){
            Vector2 objPos = _playerInput.gamePad.transform.position;
            Vector2 right = _playerInput.gamePad.transform.right;
            Vector2 up = _playerInput.gamePad.transform.up;
            Vector2 pointOffset = (worlPt - objPos);
            float x = Vector2.Dot(pointOffset, right);
            float y = Vector2.Dot(pointOffset, up);

            return new Vector2(x, y);
        }

        internal void TouchMoveControl(){
            Vector3 pos = _playerInput.gamePad.transform.position;
            Vector2 radiusPositive = new Vector2(pos.x + _playerInput.gamePadRadius, pos.y + _playerInput.gamePadRadius);
            Vector2 radiusNegative = new Vector2(pos.x - _playerInput.gamePadRadius, pos.y - _playerInput.gamePadRadius);

            if (Input.GetMouseButton(0)) {
                Vector2 mousePos = GameManager.PlayerCamera.ScreenToWorldPoint(Input.mousePosition);
                if (mousePos.x < radiusPositive.x && mousePos.y < radiusPositive.y && mousePos.x > radiusNegative.x &&
                    mousePos.y > radiusNegative.y) {
                    Vector2 gamepadTouch = WorldToGamepad(mousePos);
                    _playerInput.movement.touchInput = gamepadTouch.normalized;
                    Vector3 transformLocalScale = _playerInput.gamePad.transform.localScale;
                    transformLocalScale.x = Mathf.Lerp(29.5f, 30f, Time.deltaTime);
                    transformLocalScale.y = Mathf.Lerp(29.5f, 30f, Time.deltaTime);
                    _playerInput.gamePad.transform.localScale = transformLocalScale;
                }
            }
            else {
                Vector3 transformLocalScale = _playerInput.gamePad.transform.localScale;
                transformLocalScale.x = Mathf.Lerp(30f, 29.5f, Time.deltaTime);
                transformLocalScale.y = Mathf.Lerp(30f, 29.5f, Time.deltaTime);
                _playerInput.gamePad.transform.localScale = transformLocalScale;
            }
        }
    }
}