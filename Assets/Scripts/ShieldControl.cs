using System;
using UnityEngine;
using static TagsAsStrings;

public class ShieldControl : MonoBehaviour {
    private const float _shieldDamage = 0.5f;
    private PlayerData _playerData;
    [NonSerialized] public bool shieldInput;
    private SphereCollider _shieldCollider;
    private SpriteRenderer _shieldSprite;

    private void Awake(){
        _shieldCollider = GetComponent<SphereCollider>();
        _shieldSprite = GetComponent<SpriteRenderer>();
        _playerData = GetComponentInParent<PlayerController>().playerData;
    }

  

    private void Update(){
     
           _shieldCollider.enabled = _playerData.ShieldIsLoaded;
           _shieldSprite.enabled = _playerData.ShieldIsLoaded;
           if (_playerData.ShieldIsLoaded) return;
           if (!shieldInput || !(PlayerData.boostCharge >= 5f)) return;
           _playerData.ShieldIsLoaded = true;
           PlayerData.boostCharge -= 5f;



    }

    private void OnTriggerEnter(Collider other){
        if (!other.CompareTag(enemyTag) || !_playerData.ShieldIsLoaded) return;
        other.gameObject.GetComponent<EnemyController>().TakeDamage(_shieldDamage);
        _playerData.ShieldIsLoaded = false;
    }
}