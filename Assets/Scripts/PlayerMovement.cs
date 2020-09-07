using System;
using UnityEngine;
using Debug = System.Diagnostics.Debug;

public class PlayerMovement : MonoBehaviour {
    [NonSerialized] public float upDownInput;
    [NonSerialized] public float sidewaysInput;
    [NonSerialized] public bool boostInput;
    
    [SerializeField] private PlayerData _playerData;
    
    private Rigidbody _rigidbody;
    private Vector2 _moveDirection;
    private Transform _transform;
    private float _boostForce;
    private float boostTimer;


    private void Awake(){
        _rigidbody = GetComponent<Rigidbody>();
        _transform = transform;
        _rigidbody.rotation.SetLookRotation(Vector3.up);
        _boostForce = _playerData.boostForce;
        BoostTimer();

        bool BoostTimer(){
            //TODO make this work plus basic movement.
            boostTimer += Time.fixedDeltaTime;
            if (!(boostTimer >= 1f)) return false;
            _playerData.boostChargeFull = true;
            return true;

        }
    }


    private void FixedUpdate(){

        //Move (wasd)
        _moveDirection = (sidewaysInput * _transform.right + upDownInput * _transform.up);
 
       float inputAmount = Mathf.Clamp01(value: Mathf.Abs(f: upDownInput) + Mathf.Abs(f: sidewaysInput));
       Vector2 velocity = _rigidbody.velocity;
       float currentSpeed = velocity.x + velocity.y;


        SetVelocity(inputAmount, currentSpeed, _boostForce);
    }


    private void SetVelocity(float inputAmount, float currentSpeed, float boostForce){
        Vector3 velocity = (_moveDirection * (currentSpeed * inputAmount));
        _rigidbody.velocity = velocity;
        
        if (boostInput && _playerData.boostChargeFull) {
            _rigidbody.AddForce(boostForce, boostForce, 0f, ForceMode.Force);
            _playerData.boostChargeFull = false;
            boostTimer = 0f;
        }
      
        
       
    }
}