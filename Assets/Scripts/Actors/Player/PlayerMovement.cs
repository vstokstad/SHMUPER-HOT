using System;
using UnityEngine;

namespace Actors.Player {
    [RequireComponent(typeof(ParticleSystem))]
    public class PlayerMovement : MonoBehaviour {
        private AudioSource _audioSource;
        private Vector2 _currentVelocity;
        private float _intensity;
        private Light _light;
        private Color _lightColor;
        [NonSerialized] private Vector2 _moveDirection;
        private ParticleSystem _particleSystem;
        private PlayerData _playerData;
        private Rigidbody _rigidbody;
        private float _inputAmount;


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

        private void Start(){
            PlayerInput.boost += Boost;
        }


        private void OnDisable(){
            PlayerInput.boost -= Boost;
        }
        

        internal void TouchInput(Vector2 gamepadTouch){
            _moveDirection = gamepadTouch;
            _inputAmount = Mathf.Clamp01(Mathf.Abs(gamepadTouch.y) + Mathf.Abs(gamepadTouch.x));
            _currentVelocity = _rigidbody.velocity;
            Vector2 velocity = _currentVelocity + _moveDirection * (_inputAmount * _playerData.acceleration);
            velocity = Vector2.ClampMagnitude(velocity, _playerData.maxSpeed);
            TrailingFlamesHandheld(velocity);
             MovePlayer(velocity);
        }

        private void Boost(){
            //TODO remove print
            print("Boost");
            if (!(PlayerData.boostCharge > 0)) return;  
            TrailingFlamesHandheld(_rigidbody.velocity);
            _rigidbody.velocity *= 3f;
            _light.intensity = _intensity * 10f;
            _light.color = Color.magenta;
            if (!_audioSource.isPlaying) {
                Handheld.Vibrate();
                _audioSource.Play();
            }

            PlayerData.boostCharge -= 3f * Time.fixedDeltaTime;
        }

        private void MovePlayer(Vector2 velocity){
            //TODO remove print
            print("MovePlayer");
            _rigidbody.velocity = velocity;
                _light.intensity = _intensity;
                _light.color = _lightColor;
                
            
        }

        private void TrailingFlamesHandheld(Vector2 velocity){
            ParticleSystem.LightsModule systemLights = _particleSystem.lights;
            if ( velocity != Vector2.zero) {
                systemLights.enabled = true;
               
                _particleSystem.Play();
            }
            else {
                _light.intensity = _intensity;
                _light.color = _lightColor;
                _particleSystem.Clear();
                systemLights.enabled = false;
            }

            ParticleSystem.ShapeModule particleSystemShape = _particleSystem.shape;
            particleSystemShape.rotation = new Vector2(_moveDirection.y * 90f, -_moveDirection.x * 90f);
        }
    }
}