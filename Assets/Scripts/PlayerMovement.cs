using System;
using UnityEngine;

[RequireComponent(typeof(ParticleSystem))]
public class PlayerMovement : MonoBehaviour {
    [SerializeField] public PlayerData playerData;


    private float _currentVelocity;
    private float _intensity;
    private Light _light;
    private Color _lightColor;
    private Vector2 _moveDirection;
    private ParticleSystem _particleSystem;

    private Rigidbody _rigidbody;
    [NonSerialized] public bool boostInput;
    [NonSerialized] public float sidewaysInput;
    [NonSerialized] public float upDownInput;

    private void Awake(){
        _light = GetComponentInChildren<Light>();
        _rigidbody = GetComponent<Rigidbody>();

        _particleSystem = GetComponent<ParticleSystem>();
        _intensity = _light.intensity;
        _lightColor = _light.color;
    }


    private void FixedUpdate(){
        //Move (wasd)
        _moveDirection = sidewaysInput * Vector3.right + upDownInput * Vector3.up;
        float inputAmount = Mathf.Clamp01(Mathf.Abs(upDownInput) + Mathf.Abs(sidewaysInput));
        _currentVelocity =
            Mathf.MoveTowards(_currentVelocity, playerData.maxSpeed, inputAmount + playerData.acceleration);
        MovePlayer(_currentVelocity);
        FireExhaust();
        playerData.RechargeTimer();
    }


    private void MovePlayer(float currentVelocity){
        Vector2 velocity = _moveDirection * currentVelocity;

        if (Boost()) {
            velocity *= playerData.boostForce;
            _rigidbody.MovePosition((Vector2) transform.position + velocity * Time.fixedDeltaTime);
            _light.intensity = _intensity * 10f;
            _light.color = Color.magenta;
            playerData.boostForce -= Time.deltaTime;
            { }
        }
        else {
            _rigidbody.MovePosition((Vector2) transform.position + velocity * Time.fixedDeltaTime);
            _light.intensity = _intensity;
            _light.color = _lightColor;
        }
    }

    private void FireExhaust(){
        ParticleSystem.LightsModule systemLights = _particleSystem.lights;
        if (sidewaysInput != 0 || upDownInput != 0) {
            systemLights.enabled = true;
            _particleSystem.Simulate(1.5f);
        }
        else {
            _particleSystem.Clear();
            systemLights.enabled = false;
        }

        ParticleSystem.ShapeModule particleSystemShape = _particleSystem.shape;
        particleSystemShape.rotation = new Vector2(_moveDirection.y * 90f, -_moveDirection.x * 90f);
    }

    private bool Boost(){
        if (!boostInput) return false;
        if (playerData.boostForce <= 0) return false;
        return true;
    }
}