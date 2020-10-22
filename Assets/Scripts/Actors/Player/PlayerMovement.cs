using System;
using Managers;
using UnityEngine;

namespace Actors.Player {
    [RequireComponent(typeof(ParticleSystem))]
    public class PlayerMovement : MonoBehaviour {
        private AudioSource _audioSource;
        private Vector3 _currentVelocity;
        private float _intensity;
        private Light _light;
        private Color _lightColor;
        [NonSerialized] private Vector3 _moveDirection;
        private ParticleSystem _particleSystem;
        private PlayerData _playerData;

        private Rigidbody _rigidbody;
        [NonSerialized] public bool boostInput;
        [NonSerialized] public float sidewaysInput;
        [NonSerialized] public float upDownInput;

        private float _inputAmount;

        //TouchControls
        [NonSerialized] public Vector2 touchInput;


        private void Awake(){
            _playerData = GetComponent<PlayerController>().playerData;
            _light = GetComponent<Light>();
            _rigidbody = GetComponent<Rigidbody>();
            _audioSource = GetComponent<AudioSource>();
            _particleSystem = GetComponent<ParticleSystem>();
            _intensity = _light.intensity;
            _lightColor = _light.color;
            _currentVelocity = _rigidbody.velocity;
        }

        private void OnEnable(){
            PlayerInput.boost += Boost;
        
        }

        private void OnDisable(){
            PlayerInput.boost -= Boost;
        }

        private void FixedUpdate(){
            if (GameManager.OnMobile) {
                TouchInput();
            }
            else {
                KeyboardInput();
            }
        }

        private void KeyboardInput(){
            _moveDirection = sidewaysInput * Vector3.right + upDownInput * Vector3.up;
            _inputAmount = Mathf.Clamp01(Mathf.Abs(upDownInput) + Mathf.Abs(sidewaysInput));
            _audioSource.panStereo = sidewaysInput;

            _currentVelocity = _rigidbody.velocity;
            Vector3 velocity = _currentVelocity + _moveDirection * (_inputAmount * _playerData.acceleration);
            velocity = Vector3.ClampMagnitude(velocity, _playerData.maxSpeed);
            TrailingFlames();
            MovePlayer(velocity);

            if (boostInput && !_audioSource.isPlaying) _audioSource.Play();
        }

        private void TouchInput(){
            _moveDirection = touchInput;
            _inputAmount = Mathf.Clamp01(Mathf.Abs(touchInput.y) + Mathf.Abs(touchInput.x));

            _currentVelocity = _rigidbody.velocity;
            Vector3 velocity = _currentVelocity + _moveDirection * (_inputAmount * _playerData.acceleration);
            velocity = Vector3.ClampMagnitude(velocity, _playerData.maxSpeed);
            TrailingFlamesHandheld();
            MovePlayer(velocity);
            if (boostInput) {
                Boost();
            }

            if (boostInput && !_audioSource.isPlaying) {
                Handheld.Vibrate();
                _audioSource.Play();
            }
        }

        private void Boost(){
            if (!(PlayerData.boostCharge > 0)) return;
            _rigidbody.velocity *= 3f;
            _light.intensity = _intensity * 10f;
            _light.color = Color.magenta;
            PlayerData.boostCharge -= 3f * Time.fixedDeltaTime;
        }

        private void MovePlayer(Vector3 velocity){
            _rigidbody.velocity = velocity;

            _light.intensity = _intensity;
            _light.color = _lightColor;
        }

        private void TrailingFlamesHandheld(){
            ParticleSystem.LightsModule systemLights = _particleSystem.lights;
            if (touchInput != Vector2.zero) {
                systemLights.enabled = true;
                _particleSystem.Simulate(1f, true, false, false);
            }
            else {
                _particleSystem.Clear();
                systemLights.enabled = false;
            }

            ParticleSystem.ShapeModule particleSystemShape = _particleSystem.shape;
            particleSystemShape.rotation = new Vector2(_moveDirection.y * 90f, -_moveDirection.x * 90f);
        }

        private void TrailingFlames(){
            ParticleSystem.LightsModule systemLights = _particleSystem.lights;
            if (sidewaysInput != 0f || upDownInput != 0f) {
                systemLights.enabled = true;
                _particleSystem.Simulate(1f, true, false, true);
            }
            else {
                _particleSystem.Clear();
                systemLights.enabled = false;
            }

            ParticleSystem.ShapeModule particleSystemShape = _particleSystem.shape;
            particleSystemShape.rotation = new Vector2(_moveDirection.y * 90f, -_moveDirection.x * 90f);
        }
    }
}