
using System;
using UnityEngine;

public class PlasmaBallEffect : MonoBehaviour {
    private float _time;
    private ParticleSystem _particleSystem;

    private void Awake(){
        _particleSystem = GetComponent<ParticleSystem>();
    }

    private void OnEnable(){
        _particleSystem.Play();
    }

    private void OnDisable(){
        _particleSystem.Stop();
    }

    private void Update(){
         _time = Time.time;
        transform.localRotation = Quaternion.Euler(_time*100f, 0f, _time*200f);
        
    }
}
