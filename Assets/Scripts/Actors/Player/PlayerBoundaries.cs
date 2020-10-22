using Managers;
using UnityEngine;

namespace Actors.Player {
    [DefaultExecutionOrder(-1001)]
    public class PlayerBoundaries : MonoBehaviour {
        private Vector3 _boundPosition;
        private float _playerHeight;
        private float _playerWidth;
        private Vector3 _cameraBounds;
        private void Awake(){
     
            Bounds b = GetComponent<MeshRenderer>().bounds;
            _cameraBounds = GameManager.CameraBounds;
            _playerWidth = b.size.x * 0.5f;
            _playerHeight = b.size.y * 0.5f;
            _boundPosition = transform.position;
        
        }

        private void FixedUpdate(){
            _boundPosition = transform.position;
            _boundPosition.x = Mathf.Clamp(_boundPosition.x, _cameraBounds.x * -1f + _playerWidth,
                _cameraBounds.x - _playerWidth);
            _boundPosition.y = Mathf.Clamp(_boundPosition.y, _cameraBounds.y * -1f + _playerHeight,
                _cameraBounds.y - _playerWidth);
            _boundPosition.z = 0f;
            transform.position = _boundPosition;
        }
    }
}