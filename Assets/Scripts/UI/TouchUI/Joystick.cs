using Actors.Player;
using Managers;
using UnityEngine;

namespace UI.TouchUI {
    public class Joystick : MonoBehaviour {
        [SerializeField] private PlayerInput playerInput;
        

        private Vector2 WorldToGamepad(Vector2 worldPt){
            Vector2 objPos = playerInput.gamePad.transform.position;
            Vector2 right = playerInput.gamePad.transform.right;
            Vector2 up = playerInput.gamePad.transform.up;
            Vector2 pointOffset = (worldPt - objPos);
            float x = Vector2.Dot(pointOffset, right);
            float y = Vector2.Dot(pointOffset, up);

            return new Vector2(x, y);
        }

        internal void TouchMoveControl(){
            Vector3 pos = playerInput.gamePad.transform.position;
            Vector2 radiusPositive = new Vector2(pos.x + playerInput.gamePadRadius, pos.y + playerInput.gamePadRadius);
            Vector2 radiusNegative = new Vector2(pos.x - playerInput.gamePadRadius, pos.y - playerInput.gamePadRadius);

            if (Input.GetMouseButton(0)) {
                Vector2 mousePos = GameManager.PlayerCamera.ScreenToWorldPoint(Input.mousePosition);
                if (mousePos.x < radiusPositive.x && mousePos.y < radiusPositive.y && mousePos.x > radiusNegative.x &&
                    mousePos.y > radiusNegative.y) {
                    Vector2 gamepadTouch = WorldToGamepad(mousePos);
                    PlayerMovement.touchInput = gamepadTouch.normalized;
                    Vector3 transformLocalScale = playerInput.gamePad.transform.localScale;
                    transformLocalScale.x = Mathf.Lerp(29.5f, 30f, Time.deltaTime);
                    transformLocalScale.y = Mathf.Lerp(29.5f, 30f, Time.deltaTime);
                    playerInput.gamePad.transform.localScale = transformLocalScale;
                }
            }
            else {
                Vector3 transformLocalScale = playerInput.gamePad.transform.localScale;
                transformLocalScale.x = Mathf.Lerp(30f, 29.5f, Time.deltaTime);
                transformLocalScale.y = Mathf.Lerp(30f, 29.5f, Time.deltaTime);
                playerInput.gamePad.transform.localScale = transformLocalScale;
            }
        }
    }
}