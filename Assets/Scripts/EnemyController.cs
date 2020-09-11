using System;
using System.Collections;
using UnityEngine;

public class EnemyController : MonoBehaviour {
    private IEnumerator _explode;

    private float _health = EnemyData.health;
    private float _level = 1f;
    private Vector3 _movement;
    private float _moveSpeed = EnemyData.moveSpeed;
    private Transform _playerTransform;
    private Rigidbody _rigidBody;
    [NonSerialized] public float crashDamage = EnemyData.crashDamage;

    private void Awake(){
        _rigidBody = GetComponent<Rigidbody>();
        _playerTransform = GameObject.FindWithTag("Player").GetComponent<Transform>();
        _explode = Explode();
    }

    private void Update(){
        Vector3 direction = _playerTransform.position - transform.position;
        _rigidBody.rotation = Quaternion.Euler(direction.x, direction.y, 0f);
        direction.Normalize();
        _movement = direction;
    }

    private void FixedUpdate(){
        Move(_movement);
    }

    private void OnBecameInvisible(){
        gameObject.SetActive(false);
    }

    public void TakeDamage(float damage){
        _health = -damage;
        if (_health <= 0f) StartCoroutine(_explode);
    }


    private void Move(Vector3 direction){
        float speedAdjust = Vector3.Distance(transform.position, _playerTransform.position);
        direction.y *= Mathf.Sin(Mathf.PI * Time.fixedDeltaTime);
        _rigidBody.AddForce(direction * (speedAdjust + _moveSpeed * Time.fixedDeltaTime), ForceMode.Acceleration);
    }


    private IEnumerator Explode(){
        ParticleSystem exp = GetComponentInChildren<ParticleSystem>();
        _rigidBody.velocity = Vector3.zero;
        exp.Play();
        _moveSpeed = 0f;
        yield return new WaitForSeconds(exp.main.duration);
        LvLUp();
        gameObject.SetActive(false);
        _playerTransform.GetComponent<PlayerController>().killCounter += 1f;
    }

    private void LvLUp(){
        _level += 1f;
        _health = _level;
        crashDamage = _level;
        _moveSpeed = EnemyData.moveSpeed;
        _moveSpeed = _level;
        _rigidBody.velocity = Vector3.zero;
        //  _rigidBody.rotation = Quaternion.Euler(0f, 0f, 0f);
        transform.localScale = new Vector3(_level, _level, _level) * 1f;
        // gameObject.GetComponent<Renderer>().material.color = new Color(0.5f * _level, 0.7f * _level, 0.2f * _level, 1);
    }
}