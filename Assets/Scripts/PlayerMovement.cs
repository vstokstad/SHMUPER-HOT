using System;
using Unity.Mathematics;
using UnityEngine;

public class PlayerMovement : MonoBehaviour {
    [NonSerialized] public float upDownInput;
    [NonSerialized] public float sidewaysInput;
    [NonSerialized] public bool boostInput;
    [SerializeField] private ParticleSystem _particleSystem;

    [SerializeField] public PlayerData playerData;

    private Rigidbody _rigidbody;
    private Vector2 _moveDirection;
    private float _boostForce;
    private float _acceleration;
    private float _currentVelocity;

    private void Awake(){
        _rigidbody = GetComponent<Rigidbody>();
        _boostForce = playerData.boostForce;
        _currentVelocity = 1f;
        _acceleration = playerData.acceleration;
        _particleSystem = GetComponentInChildren<ParticleSystem>();
    }


    private void FixedUpdate(){
        //Move (wasd)
        _moveDirection = ((sidewaysInput * Vector3.right) + (upDownInput * Vector3.up));
       
      

        float inputAmount = Mathf.Clamp01(value: Mathf.Abs(f: upDownInput) + Mathf.Abs(f: sidewaysInput));
        _currentVelocity = Mathf.MoveTowards(_currentVelocity, playerData.maxSpeed, inputAmount + _acceleration);
        SetVelocity(_currentVelocity);
    FireExhaust();
      

        playerData.BoostTimer();
    }


    private void SetVelocity(float currentVelocity){
        Vector2 velocity = _moveDirection * currentVelocity;
        if (boostInput) {
            if (playerData.boostChargeFull) {
                _rigidbody.AddForce(velocity * _boostForce, ForceMode.Impulse);
                playerData.boostTimer += 10f;
                Debug.Log("Boost!!");
            }
            else {
                Debug.Log("Boost still Charging");
                _rigidbody.AddForce(velocity, ForceMode.Acceleration);
            }
        }
        else {
            _rigidbody.AddForce(velocity * _acceleration, ForceMode.Acceleration);
        }
    }

    private void FireExhaust(){
        ParticleSystem.LightsModule particleSystemLights = _particleSystem.lights;
       
        if (sidewaysInput != 0 || upDownInput != 0) {
            particleSystemLights.enabled = true;
            _particleSystem.Simulate(1f, true, true, false);
        }
        else {
            _particleSystem.Clear();
            particleSystemLights.enabled = false;
          
        }

        ParticleSystem.ShapeModule particleSystemShape = _particleSystem.shape;
        particleSystemShape.rotation = new Vector2(_moveDirection.y*90f, -_moveDirection.x*90f);
           
    }
}