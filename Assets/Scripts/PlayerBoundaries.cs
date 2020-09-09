using UnityEngine;

public class PlayerBoundaries : MonoBehaviour {
    //Keep player inside the cameraScreen
    private float _playerWidth;
    private float _playerHeight;
    private Vector3 _boundPosition;

    private void Awake(){
        _playerWidth = gameObject.GetComponent<MeshRenderer>().bounds.size.x / 2;
        _playerHeight = gameObject.GetComponent<MeshRenderer>().bounds.size.y / 2;
        _boundPosition = gameObject.transform.position;
    }

    private void LateUpdate(){
        _boundPosition = transform.position;
        _boundPosition.x = Mathf.Clamp(_boundPosition.x, GameManager.CameraBounds.x * -1 + _playerWidth,
            GameManager.CameraBounds.x - _playerWidth);
        _boundPosition.y = Mathf.Clamp(_boundPosition.y, GameManager.CameraBounds.y * -1 + _playerHeight,
            GameManager.CameraBounds.y - _playerWidth);
        _boundPosition.z = 0f;
        transform.position = _boundPosition;
    }
}