using UnityEngine;

public class PlayerBoundaries : MonoBehaviour {
    private Vector3 _boundPosition;

    private float _playerHeight;

    //Keep player inside the cameraScreen
    private float _playerWidth;

    private void Awake(){
        GameObject o = gameObject;
        Bounds b = o.GetComponent<MeshRenderer>().bounds;

        _playerWidth = b.size.x / 2;
        _playerHeight = b.size.y / 2;
        _boundPosition = o.transform.position;
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