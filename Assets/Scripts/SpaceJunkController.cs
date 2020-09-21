using UnityEngine;

public class SpaceJunkController : MonoBehaviour {
    private Vector3 _angularVelocity;
    private Vector3 _initialPosition;
    private Quaternion _initialRotation;
    private Rigidbody _rigidbody;
    private Quaternion _rotation;
    private float _scale;
    private float _speed;
    private Vector3 _velocity;


    private void Awake(){
        _scale = Mathf.Clamp(Random.value * Mathf.PI, 1f, 5f);
        _speed = Random.Range(5f, 15f);
        _initialRotation = Quaternion.LookRotation(Vector3.left, Vector3.up);
        _initialPosition = new Vector3(GameManager.CameraBounds.x + 2f, Random.Range(-8f, GameManager.CameraBounds.y));
        _rigidbody = GetComponent<Rigidbody>();
        _angularVelocity = new Vector3(Random.Range(-10f, 10f), Random.Range(-10f, 10f));
        _velocity = new Vector3(Random.Range(-2f, -10f), Mathf.Sin(Random.Range(-2f, 2f)));
        transform.localScale = new Vector3(_scale, _scale, _scale);
    }

    private void FixedUpdate(){
        _rigidbody.angularVelocity = _angularVelocity * (_speed * Time.fixedDeltaTime);
        _velocity.y = Mathf.Sin(Mathf.PI * Time.fixedDeltaTime);
        _rigidbody.velocity = _velocity * (_speed * Time.fixedDeltaTime);
    }

    private void OnEnable(){
        Transform transform1 = transform;
        transform1.position = _initialPosition;
        transform1.rotation = _initialRotation;
        gameObject.SetActive(true);
    }

    private void OnDisable(){
        Transform transform1 = transform;
        transform1.position = _initialPosition;
        transform1.rotation = _initialRotation;
    }

    private void OnBecameInvisible(){
        gameObject.SetActive(false);
    }
}