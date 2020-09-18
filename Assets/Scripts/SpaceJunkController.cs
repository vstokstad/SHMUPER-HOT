using System;
using UnityEngine;
using Random = UnityEngine.Random;

public class SpaceJunkController : MonoBehaviour {
    private Vector3 _angularVelocity;
    private Vector3 _initialPosition;
    private Rigidbody _rigidbody;
    private Quaternion _initialRotation;
    private float _speed;
    private Vector3 _velocity;
    private float _scale;
    private Quaternion _rotation;
    

    private void Awake(){
        _scale = Random.value * Mathf.PI;
        _speed = Random.Range(10f, 20f);
        _initialRotation = Quaternion.LookRotation(Vector3.left, Vector3.up);
        _initialPosition = new Vector3(GameManager.CameraBounds.x + 2f, Random.Range(-8f, GameManager.CameraBounds.y));
        _rigidbody = GetComponent<Rigidbody>();
        _angularVelocity = new Vector3(Random.Range(-2f, 2f), Random.Range(-1f, 2f));
        _velocity = new Vector3(Random.Range(-10f, 50f), Random.Range(-1f, 2f));
        transform.localScale = new Vector3(_scale, _scale,_scale);
    
    }

    private void FixedUpdate(){
        _rotation.x *= Time.fixedDeltaTime;
        _rotation.y *= Time.fixedDeltaTime;
     
        _rigidbody.angularVelocity = _angularVelocity * (_speed * Time.fixedDeltaTime);
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