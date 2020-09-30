using System;
using UnityEngine;
using UnityEngine.InputSystem;

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
    private TimeManager _timeManager;
    private WeaponController _weaponController;
   
    private Rigidbody _rigidbody;
    [NonSerialized] public bool boostInput;
    [NonSerialized] public float sidewaysInput;
    [NonSerialized] public float upDownInput;

    private void Awake(){
        _playerData = GetComponent<PlayerController>().playerData;
        _light = GetComponent<Light>();
        _rigidbody = GetComponent<Rigidbody>();
        _audioSource = GetComponent<AudioSource>();
        _particleSystem = GetComponent<ParticleSystem>();
        _intensity = _light.intensity;
        _lightColor = _light.color;
        _timeManager = FindObjectOfType<TimeManager>();
        _weaponController = FindObjectOfType<WeaponController>();
        

    }
    public void OnFire(InputAction.CallbackContext context)
    {
        _weaponController.Fire();
    }

    public void OnMove(InputAction.CallbackContext context){
        
            var value = context.ReadValue<Vector2>();
        _moveDirection = value * Vector3.right + value * Vector3.up;
        float inputAmount = Mathf.Clamp01(value.y + value.x);
        _currentVelocity = _rigidbody.velocity;
        Vector3 velocity = _currentVelocity + _moveDirection * (inputAmount * _playerData.acceleration);
        velocity = Vector3.ClampMagnitude(velocity, _playerData.maxSpeed);
        MovePlayer(velocity);
        
        _audioSource.panStereo = value.x;
        _timeManager.timeState = TimeState.Normal;
        if (boostInput && !_audioSource.isPlaying) _audioSource.Play();
    }
#if ENABLE_LEGACY_INPUT_MANAGER
    private void FixedUpdate(){
        _moveDirection = sidewaysInput * Vector3.right + upDownInput * Vector3.up;
        float inputAmount = Mathf.Clamp01(Mathf.Abs(upDownInput) + Mathf.Abs(sidewaysInput));
        _currentVelocity = _rigidbody.velocity;
        Vector3 velocity = _currentVelocity + _moveDirection * (inputAmount * _playerData.acceleration);
        velocity = Vector3.ClampMagnitude(velocity, _playerData.maxSpeed);
        MovePlayer(velocity);
        
        _audioSource.panStereo = sidewaysInput;
        if (boostInput && !_audioSource.isPlaying) _audioSource.Play();
    }
#endif

    private void MovePlayer(Vector3 velocity){
        TrailingFlames();
        if (boostInput && PlayerData.boostCharge > 0) {
            velocity *= 3f;

            _rigidbody.velocity = velocity;
            _light.intensity = _intensity * 10f;
            _light.color = Color.magenta;
            PlayerData.boostCharge -= 3f*Time.fixedDeltaTime;
        }
        else {
            _rigidbody.velocity = velocity;

            _light.intensity = _intensity;
            _light.color = _lightColor;
        }
    }


    private void TrailingFlames(){
        ParticleSystem.LightsModule systemLights = _particleSystem.lights;
        if (sidewaysInput != 0 || upDownInput != 0) {
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